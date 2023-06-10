// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class DriverRegistrationModel {
  final String? uid;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? status;

  final XFile? profileImage;
  final XFile? idImage;
  final XFile? cnicFrontImage;
  final XFile? cnicBackImage;
  final XFile? licenseFrontImage;
  final XFile? licenseBackImage;
  final XFile? vehicleRegCertFrontImage;
  final XFile? vehicleImage;
  final String? vehicleType;

  DriverRegistrationModel({
    this.uid,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.status,
    this.profileImage,
    this.idImage,
    this.cnicFrontImage,
    this.cnicBackImage,
    this.licenseFrontImage,
    this.licenseBackImage,
    this.vehicleRegCertFrontImage,
    this.vehicleImage,
    this.vehicleType,
  });

  DriverRegistrationModel copyWith({
    String? uid,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    XFile? profileImage,
    String? status,
    XFile? idImage,
    XFile? cnicFrontImage,
    XFile? cnicBackImage,
    XFile? licenseFrontImage,
    XFile? licenseBackImage,
    XFile? vehicleRegCertFrontImage,
    XFile? vehicleImage,
    String? vehicleType,
  }) {
    return DriverRegistrationModel(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      status: status ?? this.status,
      idImage: idImage ?? this.idImage,
      cnicFrontImage: cnicFrontImage ?? this.cnicFrontImage,
      cnicBackImage: cnicBackImage ?? this.cnicBackImage,
      licenseFrontImage: licenseFrontImage ?? this.licenseFrontImage,
      licenseBackImage: licenseBackImage ?? this.licenseBackImage,
      vehicleRegCertFrontImage:
          vehicleRegCertFrontImage ?? this.vehicleRegCertFrontImage,
      vehicleImage: vehicleImage ?? this.vehicleImage,
      vehicleType: vehicleType ?? this.vehicleType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'status': status,
      'idImage': idImage,
      'cnicFrontImage': cnicFrontImage,
      'cnicBackImage': cnicBackImage,
      'licenseFrontImage': licenseFrontImage,
      'licenseBackImage': licenseBackImage,
      'vehicleRegCertFrontImage': vehicleRegCertFrontImage,
      'vehicleImage': vehicleImage,
      'vehicleType': vehicleType,
    };
  }

  factory DriverRegistrationModel.fromMap(Map<String, dynamic> map) {
    return DriverRegistrationModel(
      uid: map['uid'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      profileImage: map['profileImage'] ?? "",
      status: map['status'] ?? "",
      idImage: map['idImage'] ?? "",
      cnicFrontImage: map['cnicFrontImage'] ?? "",
      cnicBackImage: map['cnicBackImage'] ?? "",
      licenseFrontImage: map['licenseFrontImage'] ?? "",
      licenseBackImage: map['licenseBackImage'] ?? "",
      vehicleRegCertFrontImage: map['vehicleRegCertFrontImage'] ?? "",
      vehicleImage: map['vehicelImage'] ?? "",
      vehicleType: map['vehicleType'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverRegistrationModel.fromJson(String source) =>
      DriverRegistrationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DriverRegistrationModel(uid: $uid, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, profileImage: $profileImage, idImage: $idImage, status: $status, cnicFrontImage: $cnicFrontImage, cnicBackImage: $cnicBackImage, licenseFrontImage: $licenseFrontImage, licenseBackImage: $licenseBackImage, vehicleRegCertFrontImage: $vehicleRegCertFrontImage), vehicleImage: $vehicleImage, vehicleType: $vehicleType)';
  }
}
