import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift_lift/features/profile/profile_pic_widget.dart';

import '../../../../commons/birthday_date_picker.dart';
import '../../../../commons/gender_selection_widget.dart';

import 'dart:io';

import 'package:path/path.dart' as Path;

import '../auth/controller/auth_controller.dart';

final selectedImageProvider = StateProvider<File?>((ref) => null);

class EditCustomerProfileScreen extends ConsumerStatefulWidget {
  const EditCustomerProfileScreen({super.key});

  @override
  _EditCustomerProfileScreenState createState() =>
      _EditCustomerProfileScreenState();
}

class _EditCustomerProfileScreenState
    extends ConsumerState<EditCustomerProfileScreen> {
  //
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider);

    Gender gender;

    _nameController = TextEditingController(text: user.displayName);
    _phoneNumberController = TextEditingController(text: user.phoneNumber);
    _addressController =
        TextEditingController(text: user.address ?? 'xxxxxxxxxxxxxxx');
    _dobController =
        TextEditingController(text: user.dateOfBirth ?? 'xx/xx/xxxx');
    _genderController = TextEditingController(text: user.gender ?? 'xxxxx');

    if (user.gender == "male") {
      gender = Gender.male;
    } else if (user.gender == "female") {
      gender = Gender.female;
    } else {
      gender = Gender.other;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatarWithAddPhotoButton(
                  radius: 64.0,
                  onImageSelected: (file) async {
                    // Do something with the selected image file
                    await uploadImage(file);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.go,
                  controller: _nameController,
                  onFieldSubmitted: (newValue) => ref
                      .watch(authControllerProvider.notifier)
                      .updateDisplayName(newValue, context),
                  enabled: true,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneNumberController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.go,
                  controller: _addressController,
                  onFieldSubmitted: (newValue) => ref
                      .watch(authControllerProvider.notifier)
                      .updateAddress(newValue, context),
                  enabled: true,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BirthdayDatePicker(
                  onDateSelected: (value) {
                    ref.read(authControllerProvider.notifier).updateDateOfBirth(
                          "${value.toLocal().day}/${value.toLocal().month}/${value.toLocal().year}",
                          context,
                        );
                  },
                ),
                const SizedBox(height: 16),
                GenderSelection(
                  onGenderSelected: (p0) {
                    ref.read(authControllerProvider.notifier).updateGender(
                          p0.toString().split('.').last,
                          context,
                        );
                  },
                  defaultGender: gender,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to upload image to Firebase Storage
  uploadImage(File imageFile) async {
    String fileName = Path.basename(imageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();

    ref.read(authControllerProvider.notifier).updateProfileImage(
          url,
          context,
        );
  }
}
