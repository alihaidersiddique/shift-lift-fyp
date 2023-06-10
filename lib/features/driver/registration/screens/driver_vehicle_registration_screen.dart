import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_lift/features/driver/registration/controllers/registration_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/app_image_picker.dart';
import '../../../../utils/commons/app_button.dart';
import '../widgets/form_step_widget.dart';

import 'dart:io' as io;

class DriverVehicleRegistrationScreen extends ConsumerStatefulWidget {
  const DriverVehicleRegistrationScreen({super.key});

  @override
  ConsumerState<DriverVehicleRegistrationScreen> createState() =>
      _VehiclePictureScreenState();
}

class _VehiclePictureScreenState
    extends ConsumerState<DriverVehicleRegistrationScreen> {
  XFile? vehicleImage;
  XFile? vehicleRegCertFrontImage;

  bool isActivate = false;

  void validateFields() async {
    if (vehicleImage == null) {
      debugPrint("i am here");
      Future.delayed(Duration.zero, () {
        showSnackBar(context, "Frontside of Vehicle is required");
      });
    } else if (vehicleRegCertFrontImage == null) {
      showSnackBar(context, "Backside of Vehicle Registration is required");
    } else {
      ref.read(registrationControllerProvider).vehicleRegistration(
            vehicleImage: vehicleImage!,
            vehicleRegistrationCertificateFrontsideImage:
                vehicleRegCertFrontImage!,
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
        title: const Text(AppText.vehicleregis),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // step 1
            const FormStepWidget(text: "6/6"),

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
              child: FittedBox(
                child: Column(
                  children: [
                    Text(
                      "Photo of your Vehicle",
                      style: GoogleFonts.kadwa(fontSize: 15),
                    ),
                    const SizedBox(height: 12),
                    // photo box
                    vehicleImage == null
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
                              File(vehicleImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                    const SizedBox(height: 12),

                    // add image button
                    ElevatedButton(
                      onPressed: () async {
                        vehicleImage = await appPickImage();
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

                    const SizedBox(height: 12),

                    const Divider(),

                    const SizedBox(height: 12),

                    Text(
                      "Frontside of Certificate of Vehicle Registration",
                      style: GoogleFonts.kadwa(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    // fisrt photo box
                    vehicleRegCertFrontImage == null
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
                              File(vehicleRegCertFrontImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),

                    const SizedBox(height: 12),

                    // add image button
                    ElevatedButton(
                      onPressed: () async {
                        vehicleRegCertFrontImage = await appPickImage();
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
            ),

            const SizedBox(height: 20.0),

            // query banner
            // Container(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   height: 60,
            //   width: 400,
            //   margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
