import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shift_lift/core/constants/constants.dart';
import 'package:shift_lift/core/models/autocomplate_prediction.dart';
import 'package:shift_lift/core/models/place_auto_complate_response.dart';
import 'package:shift_lift/features/home/components/network_utility.dart';
import 'package:shift_lift/features/home/components/vehicle_tile_widget.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import '../../core/providers/driver_request_providers.dart';
import '../../utils/utils.dart';
import '../screens.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'dart:ui' as ui;

final selectedTileProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _pickUpController = TextEditingController();
  final _dropOffController = TextEditingController();

  Future<QuerySnapshot> fetchAppVehicles() async {
    return await FirebaseFirestore.instance.collection('appVehicles').get();
  }

  late LatLng destination;
  late LatLng source;

  @override
  void initState() {
    super.initState();
    loadCustomMarker();
  }

  late Uint8List markIcons;

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

  @override
  void dispose() {
    _pickUpController.dispose();
    _dropOffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var markers = ref.read(markersProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white, size: 22),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () async => openDrawer(),
              icon: Icon(Icons.menu, color: Colors.grey[300]),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),

          // location pickup
          buildSourceTextField(markers),
          const SizedBox(height: 10.0),

          // location destination
          buildDestinationTextField(markers),
          const SizedBox(height: 20.0),

          // vehicles list
          verticalSlider(ref)
        ],
      ),
      bottomNavigationBar: AppButton(
        text: "Find a driver",
        onTap: () => Routemaster.of(context).push('/drive-request-screen'),
      ),
    );
  }

  void openDrawer() async {
    await showTopModalSheet<String?>(
      context,
      Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                const Text(
                  "SHIFT LIFT",
                  style:
                      TextStyle(color: AppColors.primaryColor, fontSize: 22.0),
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Wrap(
              runSpacing: 10.0,
              spacing: 25.0,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                DrawerItemButton(
                  icon: Icons.home,
                  label: "Home",
                  onPressed: () {},
                ),
                DrawerItemButton(
                  icon: Icons.history,
                  label: "Requests",
                  onPressed: () {},
                ),
                DrawerItemButton(
                  icon: Icons.man,
                  label: "Profile",
                  onPressed: () {},
                ),
                DrawerItemButton(
                  icon: Icons.help,
                  label: "Help",
                  onPressed: () {},
                ),
                DrawerItemButton(
                  icon: Icons.change_circle,
                  label: "Driver",
                  onPressed: () => Routemaster.of(context)
                      .push('/driver-regsitration-screen'),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
          ],
        ),
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
                onTap: () => ref
                    .read(selectedTileProvider.notifier)
                    .update((state) => index),
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

  TextEditingController destinationController = TextEditingController();
  TextEditingController sourceController = TextEditingController();

  bool showSourceField = false;

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

  Widget buildDestinationTextField(var markers) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 15),
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
        controller: destinationController,
        readOnly: true,
        onTap: () async {
          Prediction? p = await showGoogleAutoComplete(context);

          String selectedPlace = p!.description!;

          destinationController.text = selectedPlace;

          ref
              .read(destinationLocationProvider.notifier)
              .update((state) => selectedPlace);

          List<geoCoding.Location> locations =
              await geoCoding.locationFromAddress(selectedPlace);

          destination = LatLng(
            locations.first.latitude,
            locations.first.longitude,
          );

          ref
              .read(destinationLatLongProvider.notifier)
              .update((state) => destination);

          ref.read(markersProvider).add(
                Marker(
                  markerId: MarkerId(selectedPlace),
                  infoWindow: InfoWindow(title: 'Destination: $selectedPlace'),
                  position: destination,
                  icon: BitmapDescriptor.fromBytes(markIcons),
                ),
              );
        },
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: 'Search for a destination',
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

  Widget buildSourceTextField(var markers) {
    return Positioned(
      top: 230,
      left: 20,
      right: 20,
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.only(left: 15),
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
          controller: sourceController,
          readOnly: true,
          onTap: () async {
            Prediction? p = await showGoogleAutoComplete(context);

            String selectedPlace = p!.description!;

            sourceController.text = selectedPlace;

            ref
                .read(sourceLocationProvider.notifier)
                .update((state) => selectedPlace);

            List<geoCoding.Location> locations =
                await geoCoding.locationFromAddress(selectedPlace);

            destination =
                LatLng(locations.first.latitude, locations.first.longitude);

            ref
                .read(sourceLatLongProvider.notifier)
                .update((state) => destination);

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
          },
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'From:',
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
      ),
    );
  }
}

class LocationFieldWidget extends StatefulWidget {
  const LocationFieldWidget({
    super.key,
    required TextEditingController pickUpController,
    required this.icon,
    required this.text,
  }) : _pickUpController = pickUpController;

  final TextEditingController _pickUpController;
  final String text;
  final IconData icon;

  @override
  State<LocationFieldWidget> createState() => _LocationFieldWidgetState();
}

class _LocationFieldWidgetState extends State<LocationFieldWidget> {
  List<AutocompletePrediction> placePredictions = [];

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": query, // query parameter
        "key": AppText.kGooglePlacesApiKey,
      },
    );

    // its time to make getv request
    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);

      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
      debugPrint(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        autofocus: false,
        controller: widget._pickUpController,
        style: const TextStyle(fontSize: 16.0),
        onChanged: (value) => placeAutoComplete(value),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          hintText: widget.text,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Colors.grey[500],
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
        ),
      ),
    );
  }
}
