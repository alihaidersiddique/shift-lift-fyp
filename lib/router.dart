import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shift_lift/features/auth/screens/name_screen.dart';
import 'package:shift_lift/features/auth/screens/sign_in_screen.dart';
import 'package:shift_lift/features/home/home_screen.dart';
import 'package:shift_lift/features/profile/profile_screen.dart';
import 'package:shift_lift/features/request_trip/booking_details_screen.dart';
import 'package:shift_lift/features/request_trip/drive_request_screen.dart';

import 'features/auth/screens/mode_screen.dart';
import 'features/auth/screens/otp_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/signin-screen': (_) => const MaterialPage(child: SignInScreen()),
  '/otp-screen': (_) => const MaterialPage(child: OTPScreen("")),
  '/name-screen': (_) => const MaterialPage(child: NameScreen()),
  '/mode-screen': (_) => const MaterialPage(child: ModeScreen()),
  '/home-screen': (_) => const MaterialPage(child: HomeScreen()),
  '/drive-request-screen': (_) => MaterialPage(child: DriveRequestScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/home-screen': (_) => const MaterialPage(child: HomeScreen()),
  '/drive-request-screen': (_) => MaterialPage(child: DriveRequestScreen()),
});
