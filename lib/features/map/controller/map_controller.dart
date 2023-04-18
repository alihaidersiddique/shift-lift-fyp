import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:shift_lift/core/constants/constants.dart';

import '../../../core/models/map_model.dart';

// users actual pick-up and drop-off locations
final pickupLatProvider = StateProvider<double>((ref) => 0.00);
final pickupLongProvider = StateProvider<double>((ref) => 0.00);

final dropoffLatProvider = StateProvider<double>((ref) => 0.00);
final dropoffLongProvider = StateProvider<double>((ref) => 0.00);

final pickupLocationProvider = StateProvider<LatLng>((ref) {
  final latitude = ref.read(pickupLatProvider);
  final longitude = ref.read(pickupLongProvider);
  return LatLng(latitude, longitude);
});

final dropoffLocationProvider = StateProvider<LatLng>((ref) {
  final latitude = ref.read(dropoffLatProvider);
  final longitude = ref.read(dropoffLongProvider);
  return LatLng(latitude, longitude);
});

// for map
final markersProvider = StateProvider<Set<Marker>>((ref) {
  return <Marker>{};
});
final mapPolylineProvider = StateProvider<Polyline>(
  (ref) {
    final source = ref.read(pickupLocationProvider);
    final destination = ref.read(dropoffLocationProvider);

    return Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blue,
      width: 5,
      points: [source, destination],
    );
  },
);

// users selected addresses in string format
final sourceLocationProvider = StateProvider<String>((ref) => "");
final destinationLocationProvider = StateProvider<String>((ref) => "");

final mapNotifierProvider =
    StateNotifierProvider<MapController, MapModel>((ref) {
  return MapController();
});

// state class
class MapController extends StateNotifier<MapModel> {
  MapController() : super(const MapModel());

  void setPickUpLocation(LatLng location) {
    state = state.copyWith(pickUpLocation: location);
  }

  void setDropOffLocation(LatLng location) {
    state = state.copyWith(dropOffLocation: location);
    if (state.pickUpLocation != null && state.dropOffLocation != null) {
      updateDistanceAndTime();
    }
  }

  Future<void> updateDistanceAndTime() async {
    final url =
        Uri.parse('https://maps.googleapis.com/maps/api/directions/json');

    final params = {
      'origin':
          '${state.pickUpLocation?.latitude},${state.pickUpLocation?.longitude}',
      'destination':
          '${state.dropOffLocation?.latitude},${state.dropOffLocation?.longitude}',
      'mode': 'driving',
      'key': AppText.kGoogleMapsApiKey,
    };

    final uri = url.replace(queryParameters: params);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'] as List<dynamic>;
      final route = routes.first;
      final legs = route['legs'] as List<dynamic>;
      final leg = legs.first;
      final distance = leg['distance']['value'] / 1000.0;
      final time = leg['duration']['value'] / 60.0;
      state = state.copyWith(distance: distance, time: time);
    }
  }
}
