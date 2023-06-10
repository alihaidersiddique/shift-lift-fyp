import 'package:flutter/foundation.dart';

enum RideStatus {
  initial,
  requested,
  booking,
  booked,
  error,
  cancelling,
  cancelled,
  onGoing,
  completing,
  completed,
}

class RideModel {
  final String rideId;
  final String pickUpAddress;
  final String dropOffAddress;
  final String customerId;
  final String customerName;
  final String customerPhoto;
  final String duration;
  final String distance;
  final String vehicleType;
  final String? rideDriver;
  final RideStatus rideStatus;
  final String? errorMessage;
  final double? pickUpLat;
  final double? pickUpLong;
  final double? dropOffLat;
  final double? dropOffLong;

  RideModel({
    required this.rideId,
    required this.pickUpAddress,
    required this.dropOffAddress,
    required this.vehicleType,
    required this.rideStatus,
    this.errorMessage,
    required this.rideDriver,
    required this.customerId,
    required this.customerName,
    required this.customerPhoto,
    required this.duration,
    required this.distance,
    required this.pickUpLat,
    required this.pickUpLong,
    required this.dropOffLat,
    required this.dropOffLong,
  });

  Map<String, dynamic> toJson() {
    return {
      'pickUpAddress': pickUpAddress,
      'dropOffAddress': dropOffAddress,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhoto': customerPhoto,
      'duration': duration,
      'distance': distance,
      'vehicleType': vehicleType,
      'status': describeEnum(rideStatus),
      'errorMessage': errorMessage,
      'pickUpLat': pickUpLat,
      'pickUpLong': pickUpLong,
      'dropOffLat': dropOffLat,
      'dropOffLong': dropOffLong,
      'rideDriver': rideDriver,
    };
  }

  factory RideModel.fromJson(Map<String, dynamic> json, String id) {
    return RideModel(
      rideId: id,
      pickUpAddress: json['pickUpAddress'] ?? "",
      dropOffAddress: json['dropOffAddress'] ?? "",
      customerId: json['customerId'] ?? "",
      customerName: json['customerName'] ?? "",
      customerPhoto: json['customerPhoto'] ?? "",
      duration: json['duration'] ?? "",
      distance: json['distance'] ?? "",
      vehicleType: json['vehicleType'] ?? "",
      rideStatus: RideStatus.values.firstWhere(
        (e) => describeEnum(e) == json['rideStatus'].toString(),
        orElse: () => RideStatus.error,
      ),
      errorMessage: json['errorMessage'] ?? "",
      pickUpLat: json['pickUpLat'] ?? 0.00,
      pickUpLong: json['pickUpLong'] ?? 0.00,
      dropOffLat: json['dropOffLat'] ?? 0.00,
      dropOffLong: json['dropOffLong'] ?? 0.00,
      rideDriver: json['rideDriver'] ?? "",
    );
  }

  RideModel copyWith({
    String? rideId,
    String? pickUpAddress,
    String? dropOffAddress,
    String? customerId,
    String? customerName,
    String? customerPhoto,
    String? duration,
    String? distance,
    String? vehicleType,
    RideStatus? rideStatus,
    String? errorMessage,
    double? dropOffLat,
    double? dropOffLong,
    double? pickUpLat,
    double? pickUpLong,
    String? rideDriver,
  }) {
    return RideModel(
      rideId: rideId ?? this.rideId,
      pickUpAddress: pickUpAddress ?? this.pickUpAddress,
      dropOffAddress: dropOffAddress ?? this.dropOffAddress,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhoto: customerPhoto ?? this.customerPhoto,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      vehicleType: vehicleType ?? this.vehicleType,
      rideStatus: rideStatus ?? this.rideStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      pickUpLat: pickUpLat ?? this.pickUpLat,
      pickUpLong: pickUpLong ?? this.pickUpLong,
      dropOffLat: dropOffLat ?? this.dropOffLat,
      dropOffLong: dropOffLong ?? this.dropOffLong,
      rideDriver: rideDriver ?? this.rideDriver,
    );
  }
}
