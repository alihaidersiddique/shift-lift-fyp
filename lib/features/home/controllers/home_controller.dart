import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ride_model.dart';
import '../repositories/home_repositories.dart';

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

    yield rides;
  }
});

class HomeController extends StateNotifier<bool> {
  final HomeRepository _homeRepository;
  final Ref _ref;

  HomeController({
    required HomeRepository homeRepository,
    required Ref ref,
  })  : _homeRepository = homeRepository,
        _ref = ref,
        super(false);

  Future<void> findDriver({required String rideId}) async {
    try {
      state = true;

      final result = await _homeRepository.findDriver(rideId: rideId);

      result.fold(
        (l) {
          state = false;
        },
        (r) {
          state = false;
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
