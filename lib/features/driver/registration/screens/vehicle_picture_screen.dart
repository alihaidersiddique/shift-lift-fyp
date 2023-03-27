import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/app_image_picker.dart';
import '../../../../utils/commons/app_button.dart';
import 'client_request_screen.dart';

class VehiclePictureScreen extends ConsumerStatefulWidget {
  const VehiclePictureScreen({super.key});

  @override
  ConsumerState<VehiclePictureScreen> createState() =>
      _VehiclePictureScreenState();
}

class _VehiclePictureScreenState extends ConsumerState<VehiclePictureScreen> {
  XFile? frontImage;
  XFile? backImage;

  bool isActivate = false;

  void validateFields() {
    if (frontImage == null) {
      debugPrint("i am here");
      showSnackBar(context, "Frontside of Vehicle is required");
    } else if (backImage == null) {
      showSnackBar(context, "Backside of Vehicle Registration is required");
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ClientRequestScreeen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppText.vehiclepic,
          style: GoogleFonts.kadwa(color: Colors.black),
        ),
      ),
      body: ColoredBox(
        color: const Color(0xffFBFBFB),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Column(
            children: [
              // step 1
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 0.25),
                  ),
                  child: Text(
                    "5/5",
                    style: GoogleFonts.kadwa(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),

              // form
              Container(
                height: 550,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                      frontImage == null
                          ? Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff696969),
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
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffFFFFFF)),
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
                      Text(
                        "Frontside of Certificate of Vehicle Registration",
                        style: GoogleFonts.kadwa(fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      // fisrt photo box
                      backImage == null
                          ? Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff696969),
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
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffFFFFFF)),
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
              const SizedBox(height: 8),

              // query banner
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                    color: const Color(0xffFFFCCF),
                    borderRadius: BorderRadius.circular(12)),
                child: RichText(
                  text: TextSpan(
                    text: 'For queries, please contact our\n ',
                    style: GoogleFonts.kadwa(color: Colors.black, fontSize: 15),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'customer support',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
