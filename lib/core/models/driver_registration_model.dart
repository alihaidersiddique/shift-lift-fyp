// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DriverRegistrationModel {
  final String uid;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String profileImage;
  final String idImage;
  final String cnicFrontImage;
  final String cnicBackImage;
  final String licenseFrontImage;
  final String licenseBackImage;
  final String vehicelRegCertFrontImage;
  final String vehicelImage;

  DriverRegistrationModel({
    required this.uid,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.idImage,
    required this.cnicFrontImage,
    required this.cnicBackImage,
    required this.licenseFrontImage,
    required this.licenseBackImage,
    required this.vehicelRegCertFrontImage,
    required this.vehicelImage,
  });

  DriverRegistrationModel copyWith({
    String? uid,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? idImage,
    String? cnicFrontImage,
    String? cnicBackImage,
    String? licenseFrontImage,
    String? licenseBackImage,
    String? vehicelRegCertFrontImage,
    String? vehicelImage,
  }) {
    return DriverRegistrationModel(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      idImage: idImage ?? this.idImage,
      cnicFrontImage: cnicFrontImage ?? this.cnicFrontImage,
      cnicBackImage: cnicBackImage ?? this.cnicBackImage,
      licenseFrontImage: licenseFrontImage ?? this.licenseFrontImage,
      licenseBackImage: licenseBackImage ?? this.licenseBackImage,
      vehicelRegCertFrontImage:
          vehicelRegCertFrontImage ?? this.vehicelRegCertFrontImage,
      vehicelImage: vehicelImage ?? this.vehicelImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'idImage': idImage,
      'cnicFrontImage': cnicFrontImage,
      'cnicBackImage': cnicBackImage,
      'licenseFrontImage': licenseFrontImage,
      'licenseBackImage': licenseBackImage,
      'vehicelRegCertFrontImage': vehicelRegCertFrontImage,
      'vehicelImage': vehicelImage,
    };
  }

  factory DriverRegistrationModel.fromMap(Map<String, dynamic> map) {
    return DriverRegistrationModel(
      uid: map['uid'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      profileImage: map['profileImage'] ?? "",
      idImage: map['idImage'] ?? "",
      cnicFrontImage: map['cnicFrontImage'] ?? "",
      cnicBackImage: map['cnicBackImage'] ?? "",
      licenseFrontImage: map['licenseFrontImage'] ?? "",
      licenseBackImage: map['licenseBackImage'] ?? "",
      vehicelRegCertFrontImage: map['vehicelRegCertFrontImage'] ?? "",
      vehicelImage: map['vehicelImage'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverRegistrationModel.fromJson(String source) =>
      DriverRegistrationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DriverRegistrationModel(uid: $uid, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, profileImage: $profileImage, idImage: $idImage, cnicFrontImage: $cnicFrontImage, cnicBackImage: $cnicBackImage, licenseFrontImage: $licenseFrontImage, licenseBackImage: $licenseBackImage, vehicelRegCertFrontImage: $vehicelRegCertFrontImage), vehicelImage: $vehicelImage)';
  }
}
