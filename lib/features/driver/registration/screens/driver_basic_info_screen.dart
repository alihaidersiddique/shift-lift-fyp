import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_lift/core/constants/constants.dart';
import '../../../../commons/app_drawer.dart';
import '../../../../core/providers/driver_registration_state_provider.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/app_image_picker.dart';
import '../../../../utils/commons/app_button.dart';

import 'dart:io' as io;

import '../controllers/registration_controller.dart';
import '../widgets/form_step_widget.dart';

class DriverBasicInfoScreen extends ConsumerStatefulWidget {
  const DriverBasicInfoScreen({super.key});

  @override
  ConsumerState<DriverBasicInfoScreen> createState() =>
      _DriverBasicInfoScreenState();
}

class _DriverBasicInfoScreenState extends ConsumerState<DriverBasicInfoScreen> {
  XFile? profileImage;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();

  void validateFields() async {
    if (profileImage == null) {
      debugPrint("i am here");
      showSnackBar(context, "Photo is required");
    } else if (fnameController.text.isEmpty) {
      showSnackBar(context, "First name is required");
    } else if (lnameController.text.isEmpty) {
      showSnackBar(context, "Last name is required");
    } else {
      ref.read(registrationControllerProvider).addBasicInfo(
            firstName: fnameController.text,
            lastName: lnameController.text,
            photo: profileImage!,
            context: context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(),
        elevation: 2.0,
        title: const Text(AppText.basicInfo),
      ),
      body: ColoredBox(
        color: const Color(0xffFBFBFB),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // step 1
              const FormStepWidget(text: "2/6"),

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
                    // photo box
                    profileImage == null
                        ? Container(
                            clipBehavior: Clip.antiAlias,
                            height: 200,
                            width: 202,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff696969),
                            ),
                            child: Image.asset(
                              "assets/images/placeholder-image.jpg",
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            clipBehavior: Clip.antiAlias,
                            height: 200,
                            width: 202,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff696969),
                            ),
                            child: Image.file(
                              File(profileImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                    const SizedBox(height: 12),

                    // add image button
                    ElevatedButton(
                      onPressed: () async {
                        profileImage = await appPickImage();
                        setState(() {});
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffFFFFFF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Text(
                        AppText.addImage,
                        style: GoogleFonts.kadwa(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // first name
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffFFFFFF),
                        border: Border.all(color: Colors.grey, width: 0.25),
                      ),
                      child: TextField(
                        controller: fnameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          border: InputBorder.none,
                          hintText: "First Name",
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // last name
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffFFFFFF),
                        border: Border.all(color: Colors.grey, width: 0.25),
                      ),
                      child: TextField(
                        controller: lnameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.0),
                          border: InputBorder.none,
                          hintText: "Last Name",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60.0),

              // // query banner
              // Container(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
      bottomNavigationBar: AppButton(
        text: AppText.next,
        onTap: validateFields,
      ),
    );
  }
}
