import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider =
    StateNotifierProvider<ImageProvider, XFile?>((ref) => ImageProvider());

class ImageProvider extends StateNotifier<XFile?> {
  ImageProvider() : super(null);

  void setImage(XFile? image) {
    state = image;
  }
}
