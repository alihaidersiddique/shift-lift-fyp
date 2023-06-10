import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shift_lift/features/auth/screens/terms_and_privacy_screen.dart';
import 'package:shift_lift/features/driver/account/screens/driver_profile_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_cnic_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_license_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_id_confirmation_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_vehicle_selection_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_ongoing_ride_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/registration_in_process_screen.dart';
import 'package:shift_lift/features/driver/ride/screens/driver_rides_history_screen.dart';
import 'package:shift_lift/features/help/help_screen.dart';
import 'package:shift_lift/features/screens.dart';

import '../../features/auth/screens/otp_screen.dart';
import '../../features/auth/screens/screens.dart';
import '../../features/driver/account/screens/edit_driver_profile_screen.dart';
import '../../features/driver/home/screens/driver_home_screen.dart';
import '../../features/driver/registration/screens/driver_basic_info_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_failure_screen.dart';
import '../../features/driver/registration/screens/driver_successful_withdraw_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_screen.dart';
import '../../features/driver/registration/screens/driver_withdrawals_screen.dart';
import '../../features/driver/registration/screens/driver_vehicle_registration_screen.dart';
import '../../features/profile/edit_customer_profile_screen.dart';
import '../../features/ride/screens/booked_ride_screen.dart';

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
      // return CheckoutScreen();
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
                // return const SignInScreen();
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
    name: '/help-screen',
    page: () => const HelpScreen(),
  ),
  GetPage(
    name: '/terms-and-privacy-screen',
    page: () => TermsAndPrivacyScreen(),
  ),
  GetPage(
    name: '/customer-profile-screen',
    page: () => const CustomerProfileScreen(),
  ),
  GetPage(
    name: '/edit-customer-profile-screen',
    page: () => const EditCustomerProfileScreen(),
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
    page: () => const DriverProfileScreen(),
  ),
  GetPage(
    name: '/edit-driver-profile-screen',
    page: () => const EditDriverProfileScreen(),
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
