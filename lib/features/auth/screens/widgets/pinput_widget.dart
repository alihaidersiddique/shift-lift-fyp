import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shift_lift/core/providers/firebase_providers.dart';
import 'package:shift_lift/features/auth/repository/auth_repository.dart';
import 'package:shift_lift/utils/app_colors.dart';

import '../../../../core/utils.dart';
import '../../controller/auth_controller.dart';

class PinputWidget extends ConsumerStatefulWidget {
  const PinputWidget({Key? key}) : super(key: key);

  @override
  _PinputWidgetState createState() => _PinputWidgetState();

  @override
  String toStringShort() => 'With Bottom Cursor';
}

class _PinputWidgetState extends ConsumerState<PinputWidget> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> verifyCode(String pin) async {
    try {
      final authController = ref.read(authControllerProvider.notifier);
      final authRepository = ref.read(authRepositoryProvider);
      authController.pin = controller.text;

      final firebaseAuth = ref.read(authProvider);

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: authController.verify,
        smsCode: pin,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        await authRepository.saveUserData(userCredential.user!);

        debugPrint("data saved method called");

        navigateTo(context, '/name-screen');
      } else {
        navigateTo(context, '/home-screen');
      }

      debugPrint("otp is correct !");
    } catch (e) {
      debugPrint("wrong otp");
      showSnackBar(context, "Invalid code");
    }
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = AppColors.primaryColor;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: const BoxDecoration(),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Form(
      key: formKey,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          length: 6,
          pinAnimationType: PinAnimationType.scale,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
          controller: controller,
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: (pin) {
            verifyCode(pin);
          },
          onChanged: (value) {},
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          showCursor: true,
          cursor: cursor,
          preFilledWidget: preFilledWidget,
          errorPinTheme: defaultPinTheme.copyDecorationWith(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.redAccent),
          ),
          // validator: (value) {
          //   if (value.toString() == controller.text) {
          //     Routemaster.of(context).push('/name-screen');
          //     return null;
          //   } else {
          //     return 'Pin is incorrect';
          //   }
          // },
        ),
      ),
    );
  }
}
