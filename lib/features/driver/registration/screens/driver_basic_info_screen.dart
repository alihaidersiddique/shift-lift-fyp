import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_lift/core/constants/constants.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/app_image_picker.dart';
import '../../../../utils/commons/app_button.dart';

import 'dart:io' as io;

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

  // Create a reference to the Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(XFile image) async {
    // Generate a unique filename for the image based on the current timestamp
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a reference to the location in Firebase Storage where the image will be stored
    Reference reference = _storage.ref().child('images/$fileName');

    // Upload the image to Firebase Storage using the putFile method
    UploadTask uploadTask = reference.putFile(io.File(image.path));

    // Wait for the upload to complete and get the download URL of the uploaded image
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  void validateFields() async {
    if (profileImage == null) {
      debugPrint("i am here");
      showSnackBar(context, "Photo is required");
    } else if (fnameController.text.isEmpty) {
      showSnackBar(context, "First name is required");
    } else if (lnameController.text.isEmpty) {
      showSnackBar(context, "Last name is required");
    } else {
      final firestore = ref.read(firestoreProvider);

      final user = ref.read(authProvider).currentUser;

      final collectionRef = firestore.collection('registeredDrivers');

      final docRef = collectionRef.doc(user!.phoneNumber);

      String downloadUrl = await uploadImage(profileImage!);

      docRef.set({
        'uid': user.uid,
        'phoneNumber': user.phoneNumber,
        'firstName': fnameController.text,
        'lastName': lnameController.text,
        'profileImage': downloadUrl,
      });

      navigateTo(context, "/driver_id_confirmation_screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppText.basicInfo,
          style: GoogleFonts.kadwa(color: Colors.black),
        ),
      ),
      body: ColoredBox(
        color: const Color(0xffFBFBFB),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    "1/5",
                    style: GoogleFonts.kadwa(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),

              // form
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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

              // query banner
              Container(
                padding: const EdgeInsets.only(left: 10.0),
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
