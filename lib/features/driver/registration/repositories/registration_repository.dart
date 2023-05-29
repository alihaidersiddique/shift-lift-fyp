import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_lift/core/failure.dart';

import '../../../../core/providers/firebase_providers.dart';

import 'dart:io' as io;

final docIdProvider = StateProvider<String>((ref) => "");

final registrationRepositoryProvider = Provider<RegistrationRepository>(
  (ref) => RegistrationRepository(
    ref: ref,
    storage: ref.read(storageProvider),
  ),
);

class RegistrationRepository {
  final ProviderRef _ref;
  final FirebaseStorage _storage;

  RegistrationRepository({
    required ProviderRef ref,
    required FirebaseStorage storage,
  })  : _ref = ref,
        _storage = storage;

  final CollectionReference _newDriversRequests =
      FirebaseFirestore.instance.collection('newDriversRequests');

  Future<Either<Failure, void>> selectVehicleType({
    required String uid,
    required String vehicleType,
  }) async {
    try {
      final docRef = _newDriversRequests
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .set({
        'uid': uid,
        'vehicleType': vehicleType,
        'status': 'pending',
      });

      return right(docRef);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Future<Either<Failure, DocumentReference>> selectVehicleType({
  //   required String uid,
  //   required String vehicleType,
  // }) async {
  //   try {
  //     final docRef = await _newDriversRequests.add(
  //       {
  //         'uid': uid,
  //         'vehicleType': vehicleType,
  //         'status': 'pending',
  //       },
  //     );

  //     _ref.read(docIdProvider.notifier).update((state) => docRef.id);

  //     return right(docRef);
  //   } on FirebaseException catch (e) {
  //     throw e.message!;
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  Future<Either<Failure, void>> addBasicInfo({
    required String firstName,
    required String lastName,
    required String profilePicUrl,
  }) async {
    try {
      final docId = _ref.read(authProvider).currentUser!.phoneNumber!;

      final res = await _newDriversRequests.doc(docId).update(
        {
          'firstName': firstName,
          'lastName': lastName,
          'profileImage': profilePicUrl,
        },
      );

      return right(res);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> idConfirmation({
    required String idPicUrl,
  }) async {
    try {
      // final docId = _ref.read(docIdProvider);
      final docId = _ref.read(authProvider).currentUser!.phoneNumber!;

      final res = await _newDriversRequests.doc(docId).update(
        {
          'idImage': idPicUrl,
        },
      );

      return right(res);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> driverCNIC({
    required String cnicFrontsideImage,
    required String cnicBacksideImage,
  }) async {
    try {
      // final docId = _ref.read(docIdProvider);
      final docId = _ref.read(authProvider).currentUser!.phoneNumber!;

      final res = await _newDriversRequests.doc(docId).update(
        {
          'cnicFrontsideImage': cnicFrontsideImage,
          'cnicBacksideImage': cnicBacksideImage,
        },
      );

      return right(res);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> driverLicense({
    required String licenseFrontsideImage,
    required String licenseBacksideImage,
  }) async {
    try {
      // final docId = _ref.read(docIdProvider);
      final docId = _ref.read(authProvider).currentUser!.phoneNumber!;

      final res = await _newDriversRequests.doc(docId).update(
        {
          'licenseFrontsideImage': licenseFrontsideImage,
          'licenseBacksideImage': licenseBacksideImage,
        },
      );

      return right(res);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> vehicleRegistration({
    required String vehcileImage,
    required String vehicleRegistrationCertificateFrontsideImage,
  }) async {
    try {
      // final docId = _ref.read(docIdProvider);
      final docId = _ref.read(authProvider).currentUser!.phoneNumber!;

      final res = await _newDriversRequests.doc(docId).update(
        {
          'vehcileImage': vehcileImage,
          'vehicleRegistrationCertificateFrontsideImage':
              vehicleRegistrationCertificateFrontsideImage,
        },
      );

      return right(res);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, String>> uploadImage(XFile image) async {
    try {
      // Generate a unique filename for the image based on the current timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a reference to the location in Firebase Storage where the image will be stored
      Reference reference = _storage.ref().child('images/$fileName');

      // Upload the image to Firebase Storage using the putFile method
      UploadTask uploadTask = reference.putFile(io.File(image.path));

      // Wait for the upload to complete and get the download URL of the uploaded image
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return right(downloadUrl);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
