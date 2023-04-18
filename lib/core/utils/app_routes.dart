import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shift_lift/features/profile/profile_screen.dart';

import '../../features/auth/screens/otp_screen.dart';
import '../../features/auth/screens/screens.dart';
import '../../features/driver/home/screens/driver_home_screen.dart';
import '../../features/driver/registration/screens/basic_info_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/ride/screens/drive_request_screen.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return const MaterialPage(child: HomeScreen());
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
          pageBuilder: (context, state) => MaterialPage(child: ProfileScreen()),
        ),
        GoRoute(
          path: 'drive-request-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DriveRequestScreen()),
        ),
        GoRoute(
          path: 'driver-regsitration-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DriverBasicInfoScreen()),
        ),
        GoRoute(
          path: 'driver-home-screen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DriverHomeScreen()),
        ),
      ],
    ),
  ],
);
