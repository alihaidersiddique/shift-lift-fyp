import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shift_lift/features/driver/home/components/driver_drawer.dart';
import 'package:shift_lift/features/driver/home/controller/home_controller.dart';
import 'package:shift_lift/features/driver/home/controller/pending_rides_controller.dart';

import '../../../../core/failure.dart';
import '../../../../core/models/ride_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../ride/controllers/ride_controller.dart';
import '../../../ride/repositories/ride_repository.dart';
import '../components/customer_request_widget.dart';

class DriverHomeScreen extends ConsumerWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Available rides...",
          style: TextStyle(),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black87),
              ),
              onPressed: () async => openDrawer(context),
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final pendingRides = ref.watch(pendingRidesProvider);

          final data = ref.watch(pendingRidesControllerProvider.notifier);

          final rideController = ref.watch(rideControllerProvider.notifier);

          final user = ref.watch(authControllerProvider);

          return pendingRides.when(
            data: (rides) {
              return ref.watch(loaderStatusProvider) == true
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: rides.length,
                        itemBuilder: (context, index) {
                          final ride = rides[index];

                          final pickUpLatLng =
                              LatLng(ride.pickUpLat!, ride.pickUpLong!);

                          final dropOffLatLng =
                              LatLng(ride.dropOffLat!, ride.dropOffLong!);

                          return CustomerRequestWidget(
                            amount: 0.00,
                            clientName: ride.customerName,
                            distance: ride.distance,
                            dropOff: ride.dropOffAddress,
                            pickUp: ride.pickUpAddress,
                            profileImage: ride.customerPhoto,
                            time: ride.duration,
                            pickUpLatLng: pickUpLatLng,
                            dropOffLatLng: dropOffLatLng,
                            onDecline: () {
                              data.declineRide(ride.rideId, context);
                            },
                            onAccept: () {
                              rideController.bookRide(
                                rideId: ride.rideId,
                                driverId: user.phoneNumber ?? "",
                              );
                              data.acceptRide(ride.rideId, context);
                            },
                          );
                        },
                      ),
                    );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text(error.toString()),
          );
        },
      ),
    );
    ;
  }
}
