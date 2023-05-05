import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/failure.dart';

final driverRegistrationRepositoryProvider =
    StateProvider<DriverRegistrationRepository>((ref) {
  return DriverRegistrationRepository();
});

class DriverRegistrationRepository {
  final CollectionReference _registeredDrivers =
      FirebaseFirestore.instance.collection('registeredDrivers');

  Future<Either<Failure, DocumentReference>> addBasicInfo({
    uid,
    phoneNumber,
    firstName,
    lastName,
    downloadUrl,
  }) async {
    try {
      final docRef = await _registeredDrivers.add(
        {
          'uid': uid,
          'phoneNumber': phoneNumber,
          'firstName': firstName,
          'lastName': lastName,
          'profileImage': downloadUrl,
        },
      );
      return right(docRef);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
