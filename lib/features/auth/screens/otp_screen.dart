import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shift_lift/core/constants/constants.dart';
import '../../../utils/app_colors.dart';
import 'widgets/pinput_widget.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen(this.verificationId, {super.key});

  final String verificationId;

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final String countryCode = "+92";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
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

          // phone verification heading
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Text(
              AppText.phoneVerification,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),

          // enter your otp heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppText.enterOtp,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40.0),

          // pin put fields
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
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
            child: const PinputWidget(),
          ),
          const SizedBox(height: 80),

          // resend code widget
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: RichText(
          //     textAlign: TextAlign.center,
          //     text: TextSpan(
          //       style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
          //       children: [
          //         const TextSpan(
          //           text: AppText.resendCode,
          //         ),
          //         TextSpan(
          //           text: " 10 ${AppText.seconds}",
          //           style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 70),
        ],
      ),
    );
  }
}
