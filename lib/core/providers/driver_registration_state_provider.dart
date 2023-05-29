import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/driver_registration_model.dart';

class DriverRegistrationState extends StateNotifier<DriverRegistrationModel> {
  DriverRegistrationState() : super(DriverRegistrationModel());

  void updateUid(String uid) {
    state = state.copyWith(uid: uid);
  }

  void updatePhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void updateFirstName(String firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void updateLastName(String lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void updateProfileImage(XFile profileImage) {
    state = state.copyWith(profileImage: profileImage);
  }

  void updateIdImage(XFile idImage) {
    state = state.copyWith(idImage: idImage);
  }

  void updateCnicFrontImage(XFile cnicFrontImage) {
    state = state.copyWith(cnicFrontImage: cnicFrontImage);
  }

  void updateCnicBackImage(XFile cnicBackImage) {
    state = state.copyWith(cnicBackImage: cnicBackImage);
  }

  void updateLicenseFrontImage(XFile licenseFrontImage) {
    state = state.copyWith(licenseFrontImage: licenseFrontImage);
  }

  void updateLicenseBackImage(XFile licenseBackImage) {
    state = state.copyWith(licenseBackImage: licenseBackImage);
  }

  void updateVehicleRegCertFrontImage(XFile vehicleRegCertFrontImage) {
    state = state.copyWith(vehicleRegCertFrontImage: vehicleRegCertFrontImage);
  }

  void updateVehicleImage(XFile vehicleImage) {
    state = state.copyWith(vehicleImage: vehicleImage);
  }

  void updateVehicleType(String vehicleType) {
    state = state.copyWith(vehicleType: vehicleType);
  }
}

final driverRegistrationProvider =
    StateNotifierProvider<DriverRegistrationState, DriverRegistrationModel>(
  (ref) => DriverRegistrationState(),
);
