import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/failure.dart';
import '../../../core/models/available_driver_model.dart';

final homeRepositoryProvider =
    Provider<HomeRepository>((ref) => HomeRepository());

class HomeRepository {
  // find driver
  Future<Either<dynamic, List<AvailableDriverModel>>> findDriver(
      {required String rideId}) async {
    try {
      final query = FirebaseFirestore.instance.collection('rides').doc(rideId);

      final snapshots = query.snapshots();

      final rideDrivers = <AvailableDriverModel>[];

      await for (final snapshot in snapshots) {
        final data = snapshot.data();
        debugPrint('snapshot data: $data');

        if (data != null && data['drivers'] != null) {
          final drivers = data['drivers'] as List<dynamic>;

          for (final driver in drivers) {
            debugPrint("id isss.... $driver");

            final query =
                FirebaseFirestore.instance.collection('users').doc(driver);

            debugPrint("query isss.... $query");

            final snapshot = await query.get();

            debugPrint('snapshot data here: ${snapshot.data()}');

            debugPrint(
                "snapshot dsiplay name: ${snapshot.data()!['displayName']}");

            if (snapshot.data() != null) {
              final availableDriver = AvailableDriverModel(
                displayName: snapshot.data()!['displayName'],
                photoUrl: snapshot.data()!['photoUrl'],
                phoneNumber: snapshot.data()!['phoneNumber'],
                duration: "",
                distance: "",
                fair: 0,
                comments: 0,
                rating: 0.0,
              );

              debugPrint(availableDriver.toString());

              rideDrivers.add(availableDriver);
            }
          }
        }
      }
      return right(rideDrivers);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
