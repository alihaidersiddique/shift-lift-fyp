import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shift_lift/features/driver/home/components/driver_drawer.dart';

import '../../../../utils/app_colors.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../ride/controllers/ride_controller.dart';
import '../../../ride/repositories/ride_repository.dart';
import '../components/customer_request_widget.dart';
import '../controller/home_controller.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.grey[300]),
              ),
              onPressed: () async => openDrawer(context),
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final data = ref.watch(pendingRidesProvider);
          final rideController = ref.watch(rideControllerProvider.notifier);
          final user = ref.watch(authControllerProvider);

          return data.when(
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
                            mapImage: "",
                            time: ride.duration,
                            pickUpLatLng: pickUpLatLng,
                            dropOffLatLng: dropOffLatLng,
                            onDecline: () => setState(() {
                              rides.removeAt(index);
                            }),
                            onAccept: () {
                              rideController.bookRide(
                                rideId: ride.rideId,
                                driverId: user.phoneNumber ?? "",
                              );
                              setState(() {
                                rides.removeAt(index);
                              });
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
  }
}
