import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_lift/features/driver/registration/driver_registration_repository.dart';

import '../../../core/models/driver_registration_model.dart';
import '../../../core/utils.dart';

final driverRegistrationControllerProvider = StateNotifierProvider<
    DriverRegistrationController, DriverRegistrationModel>((ref) {
  return DriverRegistrationController(
      ref.watch(driverRegistrationRepositoryProvider));
});

class DriverRegistrationController
    extends StateNotifier<DriverRegistrationModel> {
  final DriverRegistrationRepository _driverRegistrationRepository;

  DriverRegistrationController(this._driverRegistrationRepository)
      : super(
          DriverRegistrationModel(
            uid: "",
            phoneNumber: "",
            firstName: "",
            lastName: "",
            profileImage: "",
            idImage: "",
            cnicFrontImage: "",
            cnicBackImage: "",
            licenseFrontImage: "",
            licenseBackImage: "",
            vehicelRegCertFrontImage: "",
            vehicelImage: "",
          ),
        );

  Future<void> addBasicInfo({
    required String uid,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String downloadUrl,
    required BuildContext context,
  }) async {
    try {
      showCircularProgressIndicator(context);

      final res = await _driverRegistrationRepository.addBasicInfo(
        uid: uid,
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: lastName,
        downloadUrl: downloadUrl,
      );

      res.fold(
        (l) {
          Navigator.pop(context);
          showSnackBar(context, l.toString());
        },
        (r) {
          state = state.copyWith(
            uid: uid,
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
            profileImage: downloadUrl,
          );

          Navigator.pop(context);
          showSnackBar(context, "Basic Info Added Successfully");
          navigateTo(context, '/driver-id-confirmation-screen');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
