import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shift_lift/core/constants/constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/utils.dart';
import '../../../utils/app_colors.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  TextEditingController nameController = TextEditingController();

  void validateName() async {
    if (nameController.text.isEmpty) {
      showSnackBar(context, "Please enter your full name");
    } else {
      final firestore = ref.read(firestoreProvider);

      final user = ref.read(authProvider).currentUser;

      final collectionRef = firestore.collection('users');

      final docRef = collectionRef.doc(user!.phoneNumber);

      docRef.update({
        'displayName': nameController.text,
      });
      // navigateTo(context, '/mode-screen');
      Get.toNamed("/mode-screen");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  AppText.shiftLift,
                  style: GoogleFonts.aladin(
                    color: Colors.white,
                    fontSize: 70,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60.0),

          // last step
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Text(
              AppText.whoAreYou,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),

          // your good name text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppText.tellYourGoodName,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30.0),

          // full name
          NameTextField(controller: nameController),
          const SizedBox(height: 30),

          // icon button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                iconSize: 35,
                onPressed: () => validateName(),
                icon: const Icon(Icons.forward),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 3,
            blurRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          focusedErrorBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: AppText.fullName,
          hintStyle: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
    );
  }
}
