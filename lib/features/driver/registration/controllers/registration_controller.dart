import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_lift/features/driver/registration/repositories/registration_repository.dart';

import '../../../../core/models/driver_registration_model.dart';
import '../../../../core/utils.dart';

final registrationControllerProvider = Provider<RegistrationController>((ref) {
  return RegistrationController(ref.read(registrationRepositoryProvider));
});

class RegistrationController extends StateNotifier<DriverRegistrationModel> {
  final RegistrationRepository _registrationRepository;

  RegistrationController(this._registrationRepository)
      : super(DriverRegistrationModel());

  Future<void> selectVehicleType({
    required String uid,
    required String vehicleType,
    required BuildContext context,
  }) async {
    try {
      showCircularProgressIndicator(context);

      final res = await _registrationRepository.selectVehicleType(
        uid: uid,
        vehicleType: vehicleType,
      );

      res.fold(
        (l) {
          Navigator.pop(context);
          showSnackBar(context, l.toString());
        },
        (r) {
          state = state.copyWith(
            uid: uid,
            vehicleType: vehicleType,
          );

          Navigator.pop(context);
          // navigateTo(context, '/driver-basic-info-screen');
          Get.toNamed("/driver-basic-info-screen");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> addBasicInfo({
    required String firstName,
    required String lastName,
    required XFile photo,
    required BuildContext context,
  }) async {
    try {
      showCircularProgressIndicator(context);

      final downloadUrl = await uploadImage(photo, context);

      final res = await _registrationRepository.addBasicInfo(
        firstName: firstName,
        lastName: lastName,
        profilePicUrl: downloadUrl,
      );

      res.fold(
        (l) {
          Navigator.pop(context);
          debugPrint("error is here");
          debugPrint(l.toString());
          showSnackBar(context, l.toString());
        },
        (r) {
          Navigator.pop(context);

          // navigateTo(context, '/driver-id-confirmation-screen');
          Get.toNamed("/driver-id-confirmation-screen");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> idConfirmation({
    required XFile photo,
    required BuildContext context,
  }) async {
    try {
      showCircularProgressIndicator(context);

      final downloadUrl = await uploadImage(photo, context);

      final res = await _registrationRepository.idConfirmation(
        idPicUrl: downloadUrl,
      );

      res.fold(
        (l) {
          Navigator.pop(context);
          debugPrint("error is here");
          debugPrint(l.toString());
          showSnackBar(context, l.toString());
        },
        (r) {
          Navigator.pop(context);

          // navigateTo(context, '/driver-cnic-screen');
          Get.toNamed("/driver-cnic-screen");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> driverCNIC({
    required XFile cnicFrontsideImage,
    required XFile cnicBacksideImage,
    required BuildContext context,
  }) async {
    try {
      showCircularProgressIndicator(context);

      final frontDownloadUrl = await uploadImage(cnicFrontsideImage, context);

      final backDownloadUrl = await uploadImage(cnicBacksideImage, context);

      final res = await _registrationRepository.driverCNIC(
        cnicFrontsideImage: frontDownloadUrl,
        cnicBacksideImage: backDownloadUrl,
      );

      res.fold(
        (l) {
          Navigator.pop(context);

          showSnackBar(context, l.toString());
        },
        (r) {
          Navigator.pop(context);

          // navigateTo(context, '/driver-license-screen');
          Get.toNamed("/driver-license-screen");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> driverLicense({
    required XFile licenseFrontsideImage,
    required XFile licenseBacksideImage,
    required BuildContext context,
  }) async {
    try {
      showCircularProgressIndicator(context);

      final frontDownloadUrl =
          await uploadImage(licenseFrontsideImage, context);

      final backDownloadUrl = await uploadImage(licenseBacksideImage, context);

      final res = await _registrationRepository.driverLicense(
        licenseFrontsideImage: frontDownloadUrl,
        licenseBacksideImage: backDownloadUrl,
      );

      res.fold(
        (l) {
          Navigator.pop(context);

          showSnackBar(context, l.toString());
        },
        (r) {
          Navigator.pop(context);

          // navigateTo(context, '/driver-vehicle-registration-screen');
          Get.toNamed("/driver-vehicle-registration-screen");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> vehicleRegistration({
    required XFile vehicleImage,
    required XFile vehicleRegistrationCertificateFrontsideImage,
    required BuildContext context,
  }) async {
    try {
      showCircularProgressIndicator(context);

      final frontDownloadUrl = await uploadImage(vehicleImage, context);

      final vehicleCertificateFrontsideImage = await uploadImage(
        vehicleRegistrationCertificateFrontsideImage,
        context,
      );

      final res = await _registrationRepository.vehicleRegistration(
        vehcileImage: frontDownloadUrl,
        vehicleRegistrationCertificateFrontsideImage:
            vehicleCertificateFrontsideImage,
      );

      res.fold(
        (l) {
          Navigator.pop(context);

          showSnackBar(context, l.toString());
        },
        (r) {
          Navigator.pop(context);

          showSnackBar(context,
              "Your request is submitted successfully. We will contact you soon.");

          // navigateTo(context, '/registration-in-process-screen');
          Get.toNamed("/registration-in-process-screen");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<String> uploadImage(XFile image, BuildContext context) async {
    try {
      final res = await _registrationRepository.uploadImage(image);

      return res.fold(
        (l) => throw l.toString(),
        (r) => r,
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
