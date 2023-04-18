import 'dart:async';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geo_coding;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:shift_lift/core/constants/constants.dart';
import 'package:shift_lift/core/utils.dart';
import 'package:shift_lift/features/home/components/vehicle_tile_widget.dart';

import '../../utils/utils.dart';
import '../auth/controller/auth_controller.dart';
import '../map/controller/map_controller.dart';
import '../ride/controllers/ride_controller.dart';
import 'components/rider_drawer.dart';

final selectedTileProvider = StateProvider<int>((ref) => -1);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _dropOffController = TextEditingController();
  final TextEditingController _pickUpController = TextEditingController();
  final TextEditingController _rideTypeController = TextEditingController();

  late LatLng destination;
  late LatLng source;
  late Uint8List markIcons;

  @override
  void initState() {
    super.initState();
    // loadCustomMarker();
  }

  Future<QuerySnapshot> fetchAppVehicles() async =>
      await FirebaseFirestore.instance.collection('appVehicles').get();

  loadCustomMarker() async {
    markIcons = await loadAsset('assets/images/dest_marker.png', 100);
  }

  Future<Uint8List> loadAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void validateFields() async {
    if (_pickUpController.text.isEmpty) {
      showSnackBar(context, "Pick-up location is required");
    } else if (_dropOffController.text.isEmpty) {
      showSnackBar(context, "Drop-off location is required");
    } else if (_rideTypeController.text.isEmpty) {
      showSnackBar(context, "Select the ride type");
    } else {
      final pickupLocation = _pickUpController.text;
      final dropoffLocation = _dropOffController.text;
      final vehicleType = _rideTypeController.text;

      final user = ref.read(authControllerProvider);
      final map = ref.read(mapNotifierProvider);

      final dropOffLat = ref.read(dropoffLatProvider);
      final dropOffLong = ref.read(dropoffLongProvider);
      final pickUpLat = ref.read(pickupLatProvider);
      final pickUpLong = ref.read(pickupLongProvider);

      ref.read(rideControllerProvider.notifier).requestRide(
            pickUpAddress: pickupLocation,
            dropOffAddress: dropoffLocation,
            customerId: user.uid,
            customerName: user.displayName,
            customerPhoto: user.photoUrl,
            distance: map.distance?.round().toString(),
            duration: map.time?.round().toString(),
            dropOffLat: dropOffLat,
            dropOffLong: dropOffLong,
            pickUpLat: pickUpLat,
            pickUpLong: pickUpLong,
          );

      navigateTo(context, '/drive-request-screen');
      debugPrint("we are navigating...");
    }
  }

  @override
  Widget build(BuildContext context) {
    var markers = ref.read(markersProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white, size: 22),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () => navigateTo(context, '/drive-request-screen'),
            icon: Icon(Icons.car_crash, color: Colors.grey[300]),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black),
              shape: MaterialStatePropertyAll(CircleBorder()),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
              ),
              onPressed: () async => openDrawer(context),
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),

          // location pickup
          buildPickUpTextField(markers),
          const SizedBox(height: 10.0),

          // location destination
          buildDropOffTextField(markers),
          const SizedBox(height: 20.0),

          // vehicles list
          verticalSlider(ref)
        ],
      ),
      bottomNavigationBar: AppButton(
        text: "Find a driver",
        onTap: () => validateFields(),
      ),
    );
  }

  Widget verticalSlider(WidgetRef ref) {
    return Expanded(
      child: FutureBuilder<QuerySnapshot>(
        future: fetchAppVehicles(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => VehicleTileWidget(
                index: index,
                onTap: () {
                  ref
                      .read(selectedTileProvider.notifier)
                      .update((state) => index);

                  _rideTypeController.text =
                      snapshot.data!.docs[index]['vehicleName'];
                },
                vehcileName: snapshot.data!.docs[index]['vehicleName'],
                vehcileCapacity: snapshot.data!.docs[index]['vehicleCapacity'],
                vehicleImage: snapshot.data!.docs[index]['vehicleImage'],
                suggestions:
                    (snapshot.data!.docs[index]['suggestions'] as List<dynamic>)
                        .map((item) => item.toString())
                        .toList(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Prediction?> showGoogleAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "pk",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: AppText.kGooglePlacesApiKey,
      components: [Component(Component.country, "pk")],
      types: [],
      hint: "Search City",
    );

    return p;
  }

  Widget buildDropOffTextField(var markers) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 15),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 4,
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: _dropOffController,
        readOnly: true,
        onTap: () async {
          Prediction? p = await showGoogleAutoComplete(context);

          String selectedPlace = p!.description!;

          _dropOffController.text = selectedPlace;

          ref
              .read(destinationLocationProvider.notifier)
              .update((state) => selectedPlace);

          List<geo_coding.Location> locations =
              await geo_coding.locationFromAddress(selectedPlace);

          ref
              .read(dropoffLatProvider.notifier)
              .update((state) => locations.first.latitude);

          ref
              .read(dropoffLongProvider.notifier)
              .update((state) => locations.first.longitude);

          destination =
              LatLng(locations.first.latitude, locations.first.longitude);

          ref
              .read(dropoffLocationProvider.notifier)
              .update((state) => destination);

          ref
              .read(mapNotifierProvider.notifier)
              .setDropOffLocation(destination);

          ref.read(markersProvider).add(
                Marker(
                  markerId: MarkerId(selectedPlace),
                  infoWindow: InfoWindow(title: 'Destination: $selectedPlace'),
                  position: destination,
                  icon: BitmapDescriptor.fromBytes(markIcons),
                ),
              );

          _dropOffController.clear();
        },
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: 'Drop Off',
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildPickUpTextField(var markers) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 15),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 10,
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: _pickUpController,
        readOnly: true,
        onTap: () async {
          Prediction? p = await showGoogleAutoComplete(context);

          String selectedPlace = p!.description!;

          _pickUpController.text = selectedPlace;

          ref
              .read(sourceLocationProvider.notifier)
              .update((state) => selectedPlace);

          List<geo_coding.Location> locations =
              await geo_coding.locationFromAddress(selectedPlace);

          destination =
              LatLng(locations.first.latitude, locations.first.longitude);

          ref
              .read(pickupLocationProvider.notifier)
              .update((state) => destination);

          ref
              .read(pickupLatProvider.notifier)
              .update((state) => locations.first.latitude);

          ref
              .read(pickupLongProvider.notifier)
              .update((state) => locations.first.longitude);

          ref.read(mapNotifierProvider.notifier).setPickUpLocation(destination);

          ref.read(markersProvider).add(
                Marker(
                  markerId: MarkerId(selectedPlace),
                  infoWindow: InfoWindow(
                    title: 'Destination: $selectedPlace',
                  ),
                  position: destination,
                  icon: BitmapDescriptor.fromBytes(markIcons),
                ),
              );

          _pickUpController.clear();
        },
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: 'Pick Up',
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
