import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shift_lift/core/type_defs.dart';

import '../../../../core/failure.dart';
import '../../../../core/models/ride_model.dart';

final pendingRidesRepositoryProvider =
    Provider.autoDispose<PendingRidesRepository>(
        (ref) => PendingRidesRepository());

class PendingRidesRepository {
  final CollectionReference _ridesCollection =
      FirebaseFirestore.instance.collection('rides');

  FutureVoid acceptRide(String rideId) async {
    try {
      return right(await _ridesCollection
          .doc(rideId)
          .update({'rideStatus': describeEnum(RideStatus.booking)}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid declineRide(String rideId) async {
    try {
      return right(await _ridesCollection
          .doc(rideId)
          .update({'rideStatus': describeEnum(RideStatus.requested)}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<Either<Failure, List<RideModel>>> getPendingRides() async* {
    try {
      final query = FirebaseFirestore.instance
          .collection('rides')
          .where('rideStatus', isEqualTo: describeEnum(RideStatus.requested))
          .orderBy('createdAt', descending: true);

      final snapshots = query.snapshots();

      await for (final snapshot in snapshots) {
        final rides = snapshot.docs
            .map((doc) => RideModel.fromJson(doc.data(), doc.id))
            .toList();

        yield right(rides);
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      yield left(Failure(e.toString()));
    }
  }
}
