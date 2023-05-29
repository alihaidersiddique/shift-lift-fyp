import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../commons/app_drawer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/app_image_picker.dart';
import '../../../../utils/commons/app_button.dart';
import '../controllers/registration_controller.dart';
import '../widgets/form_step_widget.dart';

class DriverCNICScreen extends ConsumerStatefulWidget {
  const DriverCNICScreen({super.key});

  @override
  ConsumerState<DriverCNICScreen> createState() => _DriverCNICScreenState();
}

class _DriverCNICScreenState extends ConsumerState<DriverCNICScreen> {
  XFile? frontImage;
  XFile? backImage;

  void validateFields() {
    if (frontImage == null) {
      debugPrint("i am here");
      showSnackBar(context, "Frontside of CNIC is required");
    } else if (backImage == null) {
      showSnackBar(context, "Backside of CNIC is required");
    } else {
      ref.read(registrationControllerProvider).driverCNIC(
            cnicFrontsideImage: frontImage!,
            cnicBacksideImage: backImage!,
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
        title: const Text(AppText.drivercnic),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // step 1
            const FormStepWidget(text: "4/6"),

            // form
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffFFFFFF),
                border: Border.all(color: Colors.grey, width: 0.25),
              ),
              child: Column(
                children: [
                  Text(
                    "Frontside of Driver's CNIC",
                    style: GoogleFonts.kadwa(fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  // first photo box
                  frontImage == null
                      ? Container(
                          clipBehavior: Clip.antiAlias,
                          height: 200,
                          width: 300,
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
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff696969),
                          ),
                          child: Image.file(
                            File(frontImage!.path),
                            fit: BoxFit.cover,
                          ),
                        ),

                  const SizedBox(height: 12),

                  // add image button
                  ElevatedButton(
                    onPressed: () async {
                      frontImage = await appPickImage();
                      setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffFFFFFF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                    ),
                    child: Text(
                      AppText.addImage,
                      style: GoogleFonts.kadwa(color: Colors.black),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Divider(),

                  const SizedBox(height: 12),

                  Text(
                    "Backside of Driver's CNIC",
                    style: GoogleFonts.kadwa(fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  // second photo box
                  backImage == null
                      ? Container(
                          clipBehavior: Clip.antiAlias,
                          height: 200,
                          width: 300,
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
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff696969),
                          ),
                          child: Image.file(
                            File(backImage!.path),
                            fit: BoxFit.cover,
                          ),
                        ),

                  const SizedBox(height: 12),

                  // add image button
                  ElevatedButton(
                    onPressed: () async {
                      backImage = await appPickImage();
                      setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffFFFFFF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
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

            // const SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: AppText.next,
        onTap: validateFields,
      ),
    );
  }
}
