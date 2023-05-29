import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shift_lift/features/driver/account/screens/driver_profile_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_cnic_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_license_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_id_confirmation_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_vehicle_selection_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_ongoing_ride_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/registration_in_process_screen.dart';
import 'package:shift_lift/features/driver/ride/screens/driver_rides_history_screen.dart';
import 'package:shift_lift/features/screens.dart';

import '../../features/auth/screens/otp_screen.dart';
import '../../features/auth/screens/screens.dart';
import '../../features/driver/home/screens/driver_home_screen.dart';
import '../../features/driver/registration/screens/driver_basic_info_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_failure_screen.dart';
import '../../features/driver/registration/screens/driver_successful_withdraw_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_screen.dart';
import '../../features/driver/registration/screens/driver_withdrawals_screen.dart';
import '../../features/driver/registration/screens/driver_vehicle_registration_screen.dart';
import '../../features/ride/screens/booked_ride_screen.dart';

// final GoRouter appRoutes = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       redirect: (context, state) async {
//         if (FirebaseAuth.instance.currentUser != null) {
//           final isDriver = await FirebaseFirestore.instance
//               .collection('users')
//               .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
//               .get()
//               .then((value) => value.data()!['mode'] == 'driver');

//           if (isDriver) {
//             return '/driver-home-screen';
//           } else {
//             return '/home-screen';
//           }
//         } else {
//           return '/sign-in-screen';
//         }
//       },
//       builder: (context, state) => SignInScreen(),
//       routes: [
//         GoRoute(
//           path: 'sign-in-screen',
//           builder: (context, state) => const SignInScreen(),
//         ),
//         GoRoute(
//           path: 'otp-screen',
//           builder: (context, state) => const OTPScreen(""),
//         ),
//         GoRoute(
//           path: 'name-screen',
//           builder: (context, state) => const NameScreen(),
//         ),
//         GoRoute(
//           path: 'mode-screen',
//           builder: (context, state) => const ModeScreen(),
//         ),
//         GoRoute(
//           path: 'home-screen',
//           builder: (context, state) => const HomeScreen(),
//         ),
//         GoRoute(
//           path: 'profile-screen',
//           builder: (context, state) => MyProfileScreen(),
//         ),
//         GoRoute(
//           path: 'available-drivers-screen',
//           builder: (context, state) => const AvailableDriversScreen(),
//         ),
//         GoRoute(
//           path: 'driver-home-screen',
//           builder: (context, state) => const DriverHomeScreen(),
//         ),
//         GoRoute(
//           path: 'driver-profile-screen',
//           builder: (context, state) => DriverProfileScreen(),
//         ),
//         GoRoute(
//           path: 'booked-ride-screen',
//           builder: (context, state) => const BookedRideScreen(),
//         ),
//         GoRoute(
//           path: 'driver-basic-info-screen',
//           builder: (context, state) => const DriverBasicInfoScreen(),
//         ),
//         GoRoute(
//           path: 'driver-id-confirmation-screen',
//           builder: (context, state) => const DriverIDConfirmationScreen(),
//         ),
//         GoRoute(
//           path: 'driver-cnic-screen',
//           builder: (context, state) => const DriverCNICScreen(),
//         ),
//         GoRoute(
//           path: 'driver-license-screen',
//           builder: (context, state) => const DriverLicenseScreen(),
//         ),
//         GoRoute(
//           path: 'driver-vehicle-selection-screen',
//           builder: (context, state) => const DriverVehicleSelectionScreen(),
//         ),
//         GoRoute(
//           path: 'driver-vehicle-registration-screen',
//           builder: (context, state) => const DriverVehicleRegistrationScreen(),
//         ),
//         GoRoute(
//           path: 'driver-ongoing-ride-screen',
//           builder: (context, state) => const DriverOnGoingRideScreen(),
//         ),
//         GoRoute(
//           path: 'driver-earnings-screen',
//           builder: (context, state) => const DriverEarningsScreen(),
//         ),
//         GoRoute(
//           path: 'driver-earnings-successful-withdraw-screen',
//           builder: (context, state) => const DriverSuccessfulWithdrawScreen(),
//         ),
//         GoRoute(
//           path: 'driver-earnings-failure-withdraw-screen',
//           builder: (context, state) =>
//               const DriverEarningsFailureWithdrawScreen(),
//         ),
//         GoRoute(
//           path: 'driver-rides-history-screen',
//           builder: (context, state) => const DriverRidesHistroyScreen(),
//         ),
//         GoRoute(
//           path: 'driver-withdrawals-screen',
//           builder: (context, state) => DriverWithdrawalsScreen(),
//         ),
//         GoRoute(
//           path: 'registration-in-process-screen',
//           builder: (context, state) => const RegistrationInProcessScreen(),
//         ),
//       ],
//     ),
//   ],
// );
import 'package:get/get.dart';

Future<bool> getDriverStatus() async {
  return await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
      .get()
      .then((value) => value.data()!['mode'] == 'driver');
}

Future<bool> getDriverApplicationStatus() async {
  return await FirebaseFirestore.instance
      .collection('newDriversRequests')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
      .get()
      .then((value) => value.data()!['status'] == 'pending');
}

final appRoutes = [
  GetPage(
    name: '/',
    page: () {
      if (FirebaseAuth.instance.currentUser != null) {
        return FutureBuilder(
          future: getDriverStatus(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return FutureBuilder(
                    future: getDriverApplicationStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == true) {
                          return const RegistrationInProcessScreen();
                        } else {
                          return const DriverHomeScreen();
                        }
                      } else {
                        return const Material(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    });
              } else {
                return const HomeScreen();
              }
            } else {
              return const Material(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      } else {
        return const SignInScreen();
      }
    },
  ),
  GetPage(
    name: '/sign-in-screen',
    page: () => const SignInScreen(),
  ),
  GetPage(
    name: '/otp-screen',
    page: () => const OTPScreen(""),
  ),
  GetPage(
    name: '/name-screen',
    page: () => const NameScreen(),
  ),
  GetPage(
    name: '/mode-screen',
    page: () => const ModeScreen(),
  ),
  GetPage(
    name: '/home-screen',
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: '/profile-screen',
    page: () => MyProfileScreen(),
  ),
  GetPage(
    name: '/available-drivers-screen',
    page: () => const AvailableDriversScreen(),
  ),
  GetPage(
    name: '/driver-home-screen',
    page: () => const DriverHomeScreen(),
  ),
  GetPage(
    name: '/driver-profile-screen',
    page: () => DriverProfileScreen(),
  ),
  GetPage(
    name: '/booked-ride-screen',
    page: () => const BookedRideScreen(),
  ),
  GetPage(
    name: '/driver-basic-info-screen',
    page: () => const DriverBasicInfoScreen(),
  ),
  GetPage(
    name: '/driver-id-confirmation-screen',
    page: () => const DriverIDConfirmationScreen(),
  ),
  GetPage(
    name: '/driver-cnic-screen',
    page: () => const DriverCNICScreen(),
  ),
  GetPage(
    name: '/driver-license-screen',
    page: () => const DriverLicenseScreen(),
  ),
  GetPage(
    name: '/driver-vehicle-selection-screen',
    page: () => const DriverVehicleSelectionScreen(),
  ),
  GetPage(
    name: '/driver-vehicle-registration-screen',
    page: () => const DriverVehicleRegistrationScreen(),
  ),
  GetPage(
    name: '/driver-ongoing-ride-screen',
    page: () => const DriverOnGoingRideScreen(),
  ),
  GetPage(
    name: '/driver-earnings-screen',
    page: () => const DriverEarningsScreen(),
  ),
  GetPage(
    name: '/driver-earnings-successful-withdraw-screen',
    page: () => const DriverSuccessfulWithdrawScreen(),
  ),
  GetPage(
    name: '/driver-earnings-failure-withdraw-screen',
    page: () => const DriverEarningsFailureWithdrawScreen(),
  ),
  GetPage(
    name: '/driver-rides-history-screen',
    page: () => const DriverRidesHistroyScreen(),
  ),
  GetPage(
    name: '/driver-withdrawals-screen',
    page: () => DriverWithdrawalsScreen(),
  ),
  GetPage(
    name: '/registration-in-process-screen',
    page: () => const RegistrationInProcessScreen(),
  ),
];
