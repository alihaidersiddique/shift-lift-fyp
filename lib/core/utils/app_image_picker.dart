import 'package:image_picker/image_picker.dart';

Future<XFile?> appPickImage() async {
  final imagePicker = ImagePicker();
  final image = await imagePicker.pickImage(source: ImageSource.gallery);

  return image;
}
