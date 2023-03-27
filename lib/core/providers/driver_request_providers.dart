import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final markersProvider = StateProvider<Set<Marker>>((ref) {
  return <Marker>{};
});

final sourceLatLongProvider = StateProvider<LatLng>((ref) {
  return const LatLng(0.0, 0.0);
});

final destinationLatLongProvider = StateProvider<LatLng>((ref) {
  return const LatLng(0.0, 0.0);
});

final mapPolylineProvider = StateProvider<Polyline>(
  (ref) {
    final source = ref.read(sourceLatLongProvider);
    final destination = ref.read(destinationLatLongProvider);

    return Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blue,
      width: 5,
      points: [source, destination],
    );
  },
);

final sourceLocationProvider = StateProvider<String>((ref) => "");
final destinationLocationProvider = StateProvider<String>((ref) => "");
