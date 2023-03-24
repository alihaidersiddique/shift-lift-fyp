import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shift_lift/core/constants/constants.dart';
import 'package:shift_lift/core/utils.dart';
import 'package:shift_lift/features/auth/controller/auth_controller.dart';
import '../../../utils/app_colors.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController phoneController = TextEditingController();

  void sendCode() {
    if (phoneController.text.isEmpty) {
      showSnackBar(context, "Please enter mobile number");
    } else if (phoneController.text.length < 10) {
      showSnackBar(context, "Invalid mobile number");
    } else {
      ref.read(authControllerProvider.notifier).signInWithPhone(
            context,
            Constants.countryCode + phoneController.text,
          );
      Routemaster.of(context).push('/otp-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Text(
              Constants.helloNiceToMeetYou,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              Constants.getShiftingWithShiftLift,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            width: double.infinity,
            height: 55,
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
            child: Row(
              children: [
                const Text(Constants.countryCode),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      focusedErrorBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: Constants.enterMobileNumber,
                      hintStyle: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => sendCode(),
                  icon: const Icon(Icons.forward),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                children: [
                  const TextSpan(
                    text: "${Constants.byCreating} ",
                  ),
                  TextSpan(
                    text: "${Constants.termsOfService} ",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: "and ",
                  ),
                  TextSpan(
                    text: "${Constants.privacyPolicy} ",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
