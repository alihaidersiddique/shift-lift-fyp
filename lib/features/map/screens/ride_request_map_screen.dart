import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/map_controller.dart';

import 'package:flutter/services.dart' show rootBundle;

class RideRequestMapScreen extends ConsumerStatefulWidget {
  const RideRequestMapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RideRequestMapScreenState();
}

class _RideRequestMapScreenState extends ConsumerState<RideRequestMapScreen> {
  // late GoogleMapController _controller;
  // final Completer<GoogleMapController> _controllerCompleter = Completer();

  // String? _mapStyle;

  // @override
  // void initState() {
  //   super.initState();

  //   rootBundle.loadString('assets/map_style.txt').then((string) {
  //     _mapStyle = string;
  //   });
  // }

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(builder: (context, ref, _) {
        return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        );

        // GoogleMap(
        //   onMapCreated: (GoogleMapController controller) {
        //     _controllerCompleter.complete(controller);
        //     _controller = controller;
        //     _controller.setMapStyle(_mapStyle);
        //   },
        //   initialCameraPosition: CameraPosition(
        //     target: ref.read(dropoffLocationProvider),
        //     zoom: 17,
        //   ),
        //   zoomControlsEnabled: false,
        //   markers: ref.read(markersProvider),
        //   polylines: <Polyline>{ref.read(mapPolylineProvider)},
        // );
      }),
    );
  }
}
