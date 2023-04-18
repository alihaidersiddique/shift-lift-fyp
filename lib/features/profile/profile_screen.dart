import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'package:shift_lift/utils/app_colors.dart';

import '../auth/controller/auth_controller.dart';

final selectedGenderProvider = StateProvider<String>((ref) => "male");

final selectedImageProvider = StateProvider<File?>((ref) => null);

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  DateTime? _selectedDate;

  final picker = ImagePicker();

  // Function to upload image to Firebase Storage
  Future<String> uploadImage(File imageFile) async {
    String fileName = Path.basename(imageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  // Function to open the dialog box
  void _showPicker(context, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () {
                    _getImageFromGallery(ref, context);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _getImageFromCamera(ref, context);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove Picture'),
                  onTap: () {
                    ref
                        .read(selectedImageProvider.notifier)
                        .update((state) => null);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  // Function to get image from gallery
  Future _getImageFromGallery(WidgetRef ref, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref
          .read(selectedImageProvider.notifier)
          .update((state) => File(pickedFile.path));

      final image = ref.read(selectedImageProvider);

      String imageUrl = await uploadImage(image!);

      // ignore: use_build_context_synchronously
      ref
          .read(authControllerProvider.notifier)
          .updateProfileImage(imageUrl, context);
    } else {
      debugPrint('No image selected.');
    }
  }

  // Function to get image from camera
  Future _getImageFromCamera(WidgetRef ref, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      ref
          .read(selectedImageProvider.notifier)
          .update((state) => File(pickedFile.path));

      final image = ref.read(selectedImageProvider);

      String imageUrl = await uploadImage(image!);

      // ignore: use_build_context_synchronously
      ref
          .read(authControllerProvider.notifier)
          .updateProfileImage(imageUrl, context);
    } else {
      debugPrint('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    debugPrint(user.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          color: AppColors.primaryColor,
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // profile image
            GestureDetector(
              onTap: () => _showPicker(context, ref),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    user.photoUrl ??
                        "https://firebasestorage.googleapis.com/v0/b/shift-lift-31fd9.appspot.com/o/no-user.png?alt=media&token=2cf37a39-dbe4-4292-8e3c-5c3e80d94a21",
                  ),
                ),
              ),
            ),

            // name field
            TextFormField(
              onFieldSubmitted: (value) {
                ref
                    .read(authControllerProvider.notifier)
                    .updateDisplayName(value, context);
              },
              decoration: InputDecoration(
                hintText: user.displayName,
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),

            // phone number field
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: user.phoneNumber,
                suffixIcon: const Icon(
                  Icons.edit_off,
                  color: AppColors.primaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),

            // address field
            TextFormField(
              onFieldSubmitted: (value) {
                ref
                    .read(authControllerProvider.notifier)
                    .updateAddress(value, context);
              },
              decoration: InputDecoration(
                hintText: user.address == "" ? "Address" : user.address,
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),

            // date of birth field
            TextFormField(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2030));
                if (picked != null && picked != _selectedDate) {
                  //
                  // ignore: use_build_context_synchronously
                  ref.read(authControllerProvider.notifier).updateDateOfBirth(
                        "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}",
                        context,
                      );
                }
              },
              decoration: InputDecoration(
                hintText:
                    user.dateOfBirth == "" ? "Date of Birth" : user.dateOfBirth,
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),

            // gender field
            DropdownButton<String>(
              isExpanded: true,
              value: ref.watch(selectedGenderProvider),
              onChanged: (String? newValue) {
                ref
                    .watch(selectedGenderProvider.notifier)
                    .update((state) => newValue!);

                ref
                    .watch(authControllerProvider.notifier)
                    .updateGender(newValue!, context);
              },
              hint: const Text("Gender"),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black.withOpacity(0.7),
                fontSize: 17,
              ),
              items: <String>['male', 'female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Positioned(
    //         top: 0,
    //         left: 0,
    //         right: 0,
    //         child: Container(
    //           height: 150,
    //           decoration: const BoxDecoration(
    //             gradient: LinearGradient(
    //               begin: Alignment.bottomLeft,
    //               end: Alignment.topCenter,
    //               colors: [
    //                 AppColors.primaryColor,
    //                 AppColors.secondaryColor,
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       const Positioned(
    //         top: 40,
    //         left: 0,
    //         child: BackButton(),
    //       ),
    //       Positioned(
    //         top: 105,
    //         right: 20,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             shape: BoxShape.circle,
    //             border: Border.all(
    //               color: AppColors.primaryColor,
    //               width: 1,
    //             ),
    //           ),
    //           child: CircleAvatar(
    //             radius: 40,
    //             backgroundImage: NetworkImage(
    //               user.photoUrl ??
    //                   "https://firebasestorage.googleapis.com/v0/b/shift-lift-31fd9.appspot.com/o/no-user.png?alt=media&token=2cf37a39-dbe4-4292-8e3c-5c3e80d94a21",
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         top: 200,
    //         left: 0,
    //         right: 0,
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Column(
    //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               // name field
    //               TextFormField(
    //                 onFieldSubmitted: (value) {
    //                   ref
    //                       .read(authControllerProvider.notifier)
    //                       .updateDisplayName(value, context);
    //                 },
    //                 decoration: InputDecoration(
    //                   hintText: user.displayName,
    //                   suffixIcon: const Icon(Icons.edit),
    //                   contentPadding: EdgeInsets.zero,
    //                 ),
    //               ),
    //               const SizedBox(height: 20),

    //               // phone number field
    //               TextFormField(
    //                 readOnly: true,
    //                 decoration: InputDecoration(
    //                   hintText: user.phoneNumber,
    //                   suffixIcon: const Icon(Icons.edit_off),
    //                   contentPadding: EdgeInsets.zero,
    //                 ),
    //               ),
    //               const SizedBox(height: 20),

    //               // address field
    //               TextFormField(
    //                 onFieldSubmitted: (value) {
    //                   ref
    //                       .read(authControllerProvider.notifier)
    //                       .updateAddress(value, context);
    //                 },
    //                 decoration: InputDecoration(
    //                   hintText: user.address == "" ? "Address" : user.address,
    //                   suffixIcon: const Icon(Icons.edit),
    //                   contentPadding: EdgeInsets.zero,
    //                 ),
    //               ),
    //               const SizedBox(height: 20),

    //               // date of birth field
    //               TextFormField(
    //                 onTap: () async {
    //                   final DateTime? picked = await showDatePicker(
    //                       context: context,
    //                       initialDate: _selectedDate ?? DateTime.now(),
    //                       firstDate: DateTime(1950),
    //                       lastDate: DateTime(2030));
    //                   if (picked != null && picked != _selectedDate) {
    //                     //
    //                     // ignore: use_build_context_synchronously
    //                     ref
    //                         .read(authControllerProvider.notifier)
    //                         .updateDateOfBirth(
    //                           "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}",
    //                           context,
    //                         );
    //                   }
    //                 },
    //                 decoration: InputDecoration(
    //                   hintText: user.dateOfBirth == ""
    //                       ? "Date of Birth"
    //                       : user.dateOfBirth,
    //                   suffixIcon: const Icon(Icons.edit),
    //                   contentPadding: EdgeInsets.zero,
    //                 ),
    //               ),
    //               const SizedBox(height: 20),

    //               // gender field
    //               DropdownButton<String>(
    //                 isExpanded: true,
    //                 value: ref.watch(selectedGenderProvider),
    //                 onChanged: (String? newValue) {
    //                   ref
    //                       .watch(selectedGenderProvider.notifier)
    //                       .update((state) => newValue!);

    //                   ref
    //                       .watch(authControllerProvider.notifier)
    //                       .updateGender(newValue!, context);
    //                 },
    //                 hint: const Text("Gender"),
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.normal,
    //                   color: Colors.black.withOpacity(0.7),
    //                   fontSize: 17,
    //                 ),
    //                 items: <String>['male', 'female'].map((String value) {
    //                   return DropdownMenuItem<String>(
    //                     value: value,
    //                     child: Text(value),
    //                   );
    //                 }).toList(),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
