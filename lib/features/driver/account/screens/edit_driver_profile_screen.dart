import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../commons/birthday_date_picker.dart';
import '../../../../commons/gender_selection_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../auth/controller/auth_controller.dart';

import 'dart:io';

import 'package:path/path.dart' as Path;

final selectedImageProvider = StateProvider<File?>((ref) => null);

class EditDriverProfileScreen extends ConsumerStatefulWidget {
  const EditDriverProfileScreen({super.key});

  @override
  _EditDriverProfileScreenState createState() =>
      _EditDriverProfileScreenState();
}

class _EditDriverProfileScreenState
    extends ConsumerState<EditDriverProfileScreen> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                'https://www.w3schools.com/w3images/avatar2.png',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        _showPicker(context, ref);
                      },
                      icon: const Icon(
                        Icons.photo_camera_rounded,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
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
                    String image = _getImageFromGallery(ref, context);
                    Navigator.of(context).pop();
                    ref
                        .read(authControllerProvider.notifier)
                        .updateProfileImage(
                          image,
                          context,
                        );

                    setState(() {});
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    String image = _getImageFromCamera(ref, context);
                    Navigator.of(context).pop();
                    ref
                        .read(authControllerProvider.notifier)
                        .updateProfileImage(
                          image,
                          context,
                        );

                    setState(() {});
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

  final picker = ImagePicker();

  String imageUrl = "";

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

  // // Function to get image from gallery
  _getImageFromGallery(WidgetRef ref, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref
          .read(selectedImageProvider.notifier)
          .update((state) => File(pickedFile.path));

      final image = ref.read(selectedImageProvider);

      imageUrl = await uploadImage(image!);

      return imageUrl;
    } else {
      debugPrint('No image selected.');
    }
  }

  // Function to get image from camera
  _getImageFromCamera(WidgetRef ref, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      ref
          .read(selectedImageProvider.notifier)
          .update((state) => File(pickedFile.path));

      final image = ref.read(selectedImageProvider);

      imageUrl = await uploadImage(image!);

      return imageUrl;
    } else {
      debugPrint('No image selected.');
    }
  }
}
