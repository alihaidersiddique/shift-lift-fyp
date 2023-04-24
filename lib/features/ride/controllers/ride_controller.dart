import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/ride_model.dart';
import '../../../core/utils.dart';
import '../repositories/ride_repository.dart';

final rideControllerProvider = StateNotifierProvider<RideController, RideModel>(
  (ref) => RideController(ref.watch(rideRepositoryProvider)),
);

class RideController extends StateNotifier<RideModel> {
  final RideRepository _rideRepository;

  RideController(this._rideRepository)
      : super(
          RideModel(
            rideId: '',
            pickUpAddress: '',
            dropOffAddress: '',
            customerId: '',
            customerName: '',
            customerPhoto: '',
            distance: '',
            duration: '',
            vehicleType: '',
            rideStatus: RideStatus.initial,
            errorMessage: '',
            pickUpLat: 0.00,
            pickUpLong: 0.00,
            dropOffLat: 0.00,
            dropOffLong: 0.00,
          ),
        );

  Future<void> requestRide({
    String? rideId,
    String? pickUpAddress,
    String? dropOffAddress,
    String? pickUpLocation,
    String? dropOffLocation,
    String? customerId,
    String? customerName,
    String? customerPhoto,
    String? distance,
    String? duration,
    String? vehicleType,
    double? dropOffLat,
    double? dropOffLong,
    double? pickUpLat,
    double? pickUpLong,
    String? docId,
    required BuildContext context,
  }) async {
    try {
      //
      final ride = RideModel(
        rideId: rideId ?? "",
        pickUpAddress: pickUpAddress ?? "",
        dropOffAddress: dropOffAddress ?? "",
        customerId: customerId ?? "",
        customerName: customerName ?? "",
        customerPhoto: customerPhoto ?? "",
        distance: distance ?? "",
        duration: duration ?? "",
        vehicleType: vehicleType ?? "",
        rideStatus: RideStatus.requested,
        dropOffLat: dropOffLat ?? 0.00,
        dropOffLong: dropOffLong ?? 0.00,
        pickUpLat: pickUpLat ?? 0.00,
        pickUpLong: pickUpLong ?? 0.00,
      );

      final res = await _rideRepository.requestRide(ride);

      res.fold(
        (l) {
          state = state.copyWith(
            rideStatus: RideStatus.error,
            errorMessage: l.toString(),
          );

          showSnackBar(context, l.message);
        },
        (r) {
          showSnackBar(context, "Your ride has been requested");

          state = state.copyWith(
            rideId: r.id,
            pickUpAddress: pickUpAddress,
            dropOffAddress: dropOffAddress,
            customerId: customerId,
            customerName: customerName,
            customerPhoto: customerPhoto,
            distance: distance,
            duration: duration,
            vehicleType: vehicleType,
            rideStatus: RideStatus.requested,
            dropOffLat: dropOffLat,
            dropOffLong: dropOffLong,
            pickUpLat: pickUpLat,
            pickUpLong: pickUpLong,
          );

          navigateTo(context, '/available-drivers-screen');
        },
      );
    } catch (e) {
      state = state.copyWith(
        rideStatus: RideStatus.error,
        errorMessage: e.toString(),
      );

      showSnackBar(context, e.toString());
    }
  }

  // book ride and update ride status along with driver id
  Future<void> bookRide({
    required String driverId,
    required String rideId,
  }) async {
    try {
      debugPrint("in book method");
      state = state.copyWith(rideStatus: RideStatus.booking);
      debugPrint("in book method");

      await _rideRepository.bookRide(rideId, driverId);
      debugPrint(" ride booked");

      state = state.copyWith(rideStatus: RideStatus.booking);
      debugPrint("Ride Status: ${state.rideStatus}");
    } catch (e) {
      state = state.copyWith(
        rideStatus: RideStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  //begin ride
  Future<void> startRide({
    required String rideId,
  }) async {
    try {
      state = state.copyWith(rideStatus: RideStatus.booking);

      await _rideRepository.beginRide(rideId);

      state = state.copyWith(
        rideStatus: RideStatus.booked,
      );
    } catch (e) {
      state = state.copyWith(
        rideStatus: RideStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  //end ride
  Future<void> endRide({
    required String rideId,
  }) async {
    try {
      state = state.copyWith(rideStatus: RideStatus.completing);

      await _rideRepository.endRide(rideId);

      state = state.copyWith(
        rideStatus: RideStatus.completed,
      );
    } catch (e) {
      state = state.copyWith(
        rideStatus: RideStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> cancelRide() async {
    try {
      state = state.copyWith(rideStatus: RideStatus.cancelling);

      await _rideRepository.cancelRide(state.rideId);

      state = state.copyWith(rideStatus: RideStatus.cancelled);
    } catch (e) {
      state = state.copyWith(
        rideStatus: RideStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
