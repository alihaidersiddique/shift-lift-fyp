import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel {
  final LatLng? pickUpLocation;
  final LatLng? dropOffLocation;
  final double? distance;
  final double? time;

  const MapModel({
    this.pickUpLocation,
    this.dropOffLocation,
    this.distance,
    this.time,
  });

  MapModel copyWith({
    LatLng? pickUpLocation,
    LatLng? dropOffLocation,
    double? distance,
    double? time,
  }) {
    return MapModel(
      pickUpLocation: pickUpLocation ?? this.pickUpLocation,
      dropOffLocation: dropOffLocation ?? this.dropOffLocation,
      distance: distance ?? this.distance,
      time: time ?? this.time,
    );
  }
}
