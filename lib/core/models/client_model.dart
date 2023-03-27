// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClientModel {
  final String time;
  final String distance;
  final double amount;
  final String profileImage;
  final String mapImage;
  final String clientName;
  final String pickUp;
  final String dropOff;
  ClientModel({
    required this.time,
    required this.distance,
    required this.amount,
    required this.profileImage,
    required this.mapImage,
    required this.clientName,
    required this.pickUp,
    required this.dropOff,
  });

  ClientModel copyWith({
    String? time,
    String? distance,
    double? amount,
    String? profileImage,
    String? mapImage,
    String? clientName,
    String? pickUp,
    String? dropOff,
  }) {
    return ClientModel(
      time: time ?? this.time,
      distance: distance ?? this.distance,
      amount: amount ?? this.amount,
      profileImage: profileImage ?? this.profileImage,
      mapImage: mapImage ?? this.mapImage,
      clientName: clientName ?? this.clientName,
      pickUp: pickUp ?? this.pickUp,
      dropOff: dropOff ?? this.dropOff,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'distance': distance,
      'amount': amount,
      'profileImage': profileImage,
      'mapImage': mapImage,
      'clientName': clientName,
      'pickUp': pickUp,
      'dropOff': dropOff,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      time: map['time'] as String,
      distance: map['distance'] as String,
      amount: map['amount'] as double,
      profileImage: map['profileImage'] as String,
      mapImage: map['mapImage'] as String,
      clientName: map['clientName'] as String,
      pickUp: map['pickUp'] as String,
      dropOff: map['dropOff'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClientModel(time: $time, distance: $distance, amount: $amount, profileImage: $profileImage, mapImage: $mapImage, clientName: $clientName, pickUp: $pickUp, dropOff: $dropOff)';
  }
}
