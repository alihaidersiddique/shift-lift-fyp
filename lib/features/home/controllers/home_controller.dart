import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ride_model.dart';

final pendingRidesProvider =
    StreamProvider.autoDispose<List<RideModel>>((ref) async* {
  final query = FirebaseFirestore.instance
      .collection('rides')
      .where('rideStatus', isEqualTo: describeEnum(RideStatus.requested))
      .orderBy('createdAt', descending: true);

  final snapshots = query.snapshots();

  await for (final snapshot in snapshots) {
    final rides = snapshot.docs
        .map((doc) => RideModel.fromJson(doc.data(), doc.id))
        .toList();

    // debugPrint(rides.length.toString());

    yield rides;
  }
});
