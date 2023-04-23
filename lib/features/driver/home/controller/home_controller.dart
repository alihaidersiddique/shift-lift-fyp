import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shift_lift/core/models/available_driver_model.dart';
import 'package:shift_lift/features/ride/controllers/ride_controller.dart';

import '../../../../core/models/ride_model.dart';

final pendingRidesProvider = StreamProvider.autoDispose<List<RideModel>>(
  (ref) async* {
    final query = FirebaseFirestore.instance
        .collection('rides')
        .where('rideStatus', isEqualTo: describeEnum(RideStatus.requested))
        .orderBy('createdAt', descending: true);

    final snapshots = query.snapshots();

    await for (final snapshot in snapshots) {
      final rides = snapshot.docs
          .map((doc) => RideModel.fromJson(doc.data(), doc.id))
          .toList();

      yield rides;
    }
  },
);

// final lastDocumentProvider = FutureProvider.autoDispose<RideModel?>(
//   (ref) async {
//     final query = FirebaseFirestore.instance
//         .collection('rides')
//         .orderBy('created_at', descending: true)
//         .where("rideStatus", isEqualTo: describeEnum(RideStatus.requested))
//         .limit(1);

//     final snapshot = await query.get();

//     if (snapshot.docs.isEmpty) {
//       return null;
//     } else {
//       return RideModel.fromJson(
//         snapshot.docs.first.data(),
//         snapshot.docs.first.id,
//       );
//     }
//   },
// );

// available drivers provider
final availableDriversProvider =
    StreamProvider.autoDispose<List<AvailableDriverModel>>(
  (ref) async* {
    final ride = ref.read(rideControllerProvider);

    debugPrint('ride id: ${ride.rideId}');

    final query =
        FirebaseFirestore.instance.collection('rides').doc(ride.rideId);

    final snapshots = query.snapshots();

    await for (final snapshot in snapshots) {
      final rideDrivers = <AvailableDriverModel>[];

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
            final ride = ref.read(rideControllerProvider);

            debugPrint("reached till here...");

            final availableDriver = AvailableDriverModel(
              displayName: snapshot.data()!['displayName'],
              photoUrl: snapshot.data()!['photoUrl'],
              phoneNumber: snapshot.data()!['phoneNumber'],
              duration: ride.duration,
              distance: ride.distance,
              fair: 0,
              comments: 0,
              rating: 0.0,
            );

            debugPrint(availableDriver.toString());

            rideDrivers.add(availableDriver);
          }
        }
      }
      yield rideDrivers;
    }
  },
);
