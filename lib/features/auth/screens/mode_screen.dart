import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shift_lift/utils/utils.dart';

import '../../../core/constants/constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../utils/app_colors.dart';
import 'widgets/mode_button_widget.dart';

class ModeScreen extends ConsumerWidget {
  const ModeScreen({super.key});

  void addMode(WidgetRef ref, String mode, BuildContext context) {
    final firestore = ref.read(firestoreProvider);

    final user = ref.read(authProvider).currentUser;

    final collectionRef = firestore.collection('users');

    final docRef = collectionRef.doc(user!.phoneNumber);

    docRef.update({'mode': mode});

    Routemaster.of(context).push('/home-screen');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // upper header
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Center(
                child: Text(
                  Constants.shiftLift,
                  style: GoogleFonts.aladin(
                    color: Colors.white,
                    fontSize: 70,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60.0),

          // select the mode
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Text(
              Constants.selectMode,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),

          // customer name here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              Constants.userName,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40.0),

          // cutomer button
          ModeButtonWidget(
            name: Constants.customer,
            onPress: () => addMode(ref, "customer", context),
          ),

          // driver button
          const SizedBox(height: 20.0),
          ModeButtonWidget(
            name: Constants.driver,
            onPress: () => addMode(ref, "driver", context),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
