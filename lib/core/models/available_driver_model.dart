// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AvailableDriverModel {
  final String? rideId;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final String? duration;
  final String? distance;
  final int? fair;
  final double? rating;
  final int? comments;

  AvailableDriverModel({
    this.rideId,
    this.phoneNumber,
    this.displayName,
    this.photoUrl,
    this.duration,
    this.distance,
    this.fair,
    this.rating,
    this.comments,
  });

  AvailableDriverModel copyWith({
    String? rideId,
    String? phoneNumber,
    String? displayName,
    String? photoUrl,
    String? duration,
    String? distance,
    int? fair,
    double? rating,
    int? comments,
  }) {
    return AvailableDriverModel(
      rideId: rideId ?? this.rideId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      fair: fair ?? this.fair,
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rideId': rideId,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'duration': duration,
      'distance': distance,
      'fair': fair,
      'rating': rating,
      'comments': comments,
    };
  }

  factory AvailableDriverModel.fromMap(Map<String, dynamic> map) {
    return AvailableDriverModel(
      rideId: map['rideId'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      displayName: map['displayName'] ?? "",
      photoUrl: map['photoUrl'] ?? "",
      duration: map['duration'] ?? "",
      distance: map['distance'] ?? "",
      fair: map['fair'] ?? 0.00,
      rating: map['rating'] ?? 0,
      comments: map['comments'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableDriverModel.fromJson(String source) =>
      AvailableDriverModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AvailableDriverModel(rideId: $rideId, phoneNumber: $phoneNumber, displayName: $displayName, photoUrl: $photoUrl, duration: $duration, distance: $distance, fair: $fair, rating: $rating, comments: $comments)';
  }
}
