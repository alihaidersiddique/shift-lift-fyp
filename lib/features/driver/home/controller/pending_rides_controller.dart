import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shift_lift/core/failure.dart';
import 'package:shift_lift/features/driver/home/repositories/pending_rides_repository.dart';

import '../../../../core/models/ride_model.dart';
import '../../../../core/utils.dart';

final pendingRidesControllerProvider =
    StateNotifierProvider.autoDispose<PendingRidesController, bool>(
  (ref) => PendingRidesController(
    ref.watch(pendingRidesRepositoryProvider),
  ),
);

class PendingRidesController extends StateNotifier<bool> {
  final PendingRidesRepository _pendingRidesRepository;

  PendingRidesController(this._pendingRidesRepository) : super(false);

  Future<void> acceptRide(String rideId, BuildContext context) async {
    try {
      state = true;

      final res = await _pendingRidesRepository.acceptRide(rideId);

      res.fold(
        (l) {
          state = false;
          showSnackBar(context, l.message);
        },
        (r) {
          state = false;
          // navigateTo(context, '/home');
        },
      );
    } catch (e) {
      state = false;
      debugPrint(e.toString());
    }
  }

  Future<void> declineRide(String rideId, BuildContext context) async {
    try {
      state = true;

      final res = await _pendingRidesRepository.declineRide(rideId);

      res.fold(
        (l) {
          state = false;
          showSnackBar(context, l.message);
        },
        (r) {
          state = false;
          // navigateTo(context, '/home');
        },
      );
    } catch (e) {
      state = false;
      debugPrint(e.toString());
    }
  }

  Stream<Either<Failure, List<RideModel>>> getPendingRides(
      BuildContext context) {
    try {
      state = true;

      final res = _pendingRidesRepository.getPendingRides();

      return res.map(
        (either) => either.fold(
          (l) {
            state = false;
            showSnackBar(context, l.message);
            return left(Failure(l.message));
          },
          (r) {
            state = false;
            debugPrint(r.toString());
            return right(r);
          },
        ),
      );
    } catch (e) {
      state = false;
      debugPrint(e.toString());
      return Stream.value(left(Failure(e.toString())));
    }
  }
}
