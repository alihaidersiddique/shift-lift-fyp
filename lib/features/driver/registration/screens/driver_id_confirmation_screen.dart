import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_lift/commons/app_drawer.dart';
import 'package:shift_lift/features/driver/registration/controllers/registration_controller.dart';
import 'package:shift_lift/features/driver/registration/widgets/form_step_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/app_image_picker.dart';
import '../../../../utils/commons/app_button.dart';

class DriverIDConfirmationScreen extends ConsumerStatefulWidget {
  const DriverIDConfirmationScreen({super.key});

  @override
  ConsumerState<DriverIDConfirmationScreen> createState() =>
      _DriverIDConfirmationScreenState();
}

class _DriverIDConfirmationScreenState
    extends ConsumerState<DriverIDConfirmationScreen> {
  XFile? idImage;

  void validateFields() {
    if (idImage == null) {
      debugPrint("I am here");
      showSnackBar(context, "Photo is required");
    } else {
      ref
          .read(registrationControllerProvider)
          .idConfirmation(photo: idImage!, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        elevation: 2.0,
        title: const Text(AppText.idconfi),
      ),
      body: ColoredBox(
        color: const Color(0xffFBFBFB),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // step 1
              const FormStepWidget(text: "3/6"),

              // form
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: Colors.grey, width: 0.25),
                ),
                child: Column(
                  children: [
                    idImage == null
                        ? Container(
                            height: 200,
                            width: 300,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff696969),
                            ),
                            child: Image.asset(
                              "assets/images/placeholder-image.jpg",
                              fit: BoxFit.cover,
                            ),
                          )
                        :
                        // photo box
                        Container(
                            height: 200,
                            width: 300,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff696969),
                            ),
                            child: Image.file(
                              File(idImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                    const SizedBox(height: 12),

                    // add image button
                    ElevatedButton(
                      onPressed: () async {
                        idImage = await appPickImage();
                        setState(() {});
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffFFFFFF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                        ),
                      ),
                      child: Text(
                        AppText.addImage,
                        style: GoogleFonts.kadwa(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // query banner
              // Container(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   margin: const EdgeInsets.symmetric(horizontal: 20.0),
              //   height: 60,
              //   width: 400,
              //   decoration: BoxDecoration(
              //       color: const Color(0xffFFFCCF),
              //       borderRadius: BorderRadius.circular(12)),
              //   child: RichText(
              //     text: TextSpan(
              //       text: 'For queries, please contact our\n ',
              //       style: GoogleFonts.kadwa(color: Colors.black, fontSize: 15),
              //       children: const <TextSpan>[
              //         TextSpan(
              //           text: 'customer support',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.green,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppButton(text: AppText.next, onTap: validateFields),
    );
  }
}
