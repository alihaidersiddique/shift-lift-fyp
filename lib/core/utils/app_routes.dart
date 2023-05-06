import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_cnic_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_license_screen.dart';
import 'package:shift_lift/features/driver/registration/screens/driver_id_confirmation_screen.dart';
import 'package:shift_lift/features/screens.dart';

import '../../features/auth/screens/otp_screen.dart';
import '../../features/auth/screens/screens.dart';
import '../../features/driver/home/screens/driver_home_screen.dart';
import '../../features/driver/registration/screens/driver_basic_info_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_failure_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_successful_withdraw_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_screen.dart';
import '../../features/driver/registration/screens/driver_earnings_withdraw_history_screen.dart';
import '../../features/driver/registration/screens/driver_vehicle_registration_screen.dart';
import '../../features/driver/registration/screens/driver_vehicle_selection_screen.dart';
import '../../features/driver/registration/screens/fare_details_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/ride/screens/available_drivers_screen.dart';
import '../../features/ride/screens/booked_ride_screen.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return MaterialPage(child: DriverEarningsFailureWithdrawScreen());
        } else {
          return const MaterialPage(child: SignInScreen());
        }
      },
      routes: [
        GoRoute(
          path: 'signin-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignInScreen()),
        ),
        GoRoute(
          path: 'otp-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: OTPScreen("")),
        ),
        GoRoute(
          path: 'name-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: NameScreen()),
        ),
        GoRoute(
          path: 'mode-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ModeScreen()),
        ),
        GoRoute(
          path: 'home-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomeScreen()),
        ),
        GoRoute(
          path: 'profile-screen',
          pageBuilder: (context, state) =>
              MaterialPage(child: MyProfileScreen()),
        ),
        GoRoute(
          path: 'available-drivers-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: AvailableDriversScreen()),
        ),
        GoRoute(
          path: 'driver-home-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DriverHomeScreen()),
        ),
        GoRoute(
          path: 'booked-ride-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: BookedRideScreen()),
        ),
        GoRoute(
          path: 'driver-basic-info-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DriverBasicInfoScreen()),
        ),
        GoRoute(
          path: 'driver-id-confirmation-screen',
          pageBuilder: (context, state) => const MaterialPage(
            child: DriverIDConfirmationScreen(),
          ),
        ),
        GoRoute(
          path: 'driver-cnic-screen',
          pageBuilder: (context, state) => const MaterialPage(
            child: DriverCNICScreen(),
          ),
        ),
        GoRoute(
          path: 'driver-license-screen',
          pageBuilder: (context, state) => const MaterialPage(
            child: DriverLicenseScreen(),
          ),
        ),
        GoRoute(
          path: 'driver-vehicle-registration-screen',
          pageBuilder: (context, state) => const MaterialPage(
            child: DriverVehicleRegistrationScreen(),
          ),
        ),
        GoRoute(
          path: 'driver-earnings-screen',
          pageBuilder: (context, state) => const MaterialPage(
            child: DriverEarningsScreen(),
          ),
        ),
        GoRoute(
          path: 'driver-earnings-successful-withdraw-screen',
          pageBuilder: (context, state) => const MaterialPage(
            child: DriverEarningsSuccessfulWithdrawScreen(),
          ),
        ),
        GoRoute(
          path: 'driver-earnings-failure-withdraw-screen',
          pageBuilder: (context, state) => const MaterialPage(
            child: DriverEarningsFailureWithdrawScreen(),
          ),
        ),
        GoRoute(
          path: 'driver-earnings-withdraw-history-screen',
          pageBuilder: (context, state) => MaterialPage(
            child: DriverEarningsWithdrawHistoryScreen(),
          ),
        ),
      ],
    ),
  ],
);
