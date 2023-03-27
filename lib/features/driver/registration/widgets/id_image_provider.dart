import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final idImageProvider =
    StateNotifierProvider<IdImageProvider, XFile?>((ref) => IdImageProvider());

class IdImageProvider extends StateNotifier<XFile?> {
  IdImageProvider() : super(null);

  void setImage(XFile? image) {
    state = image;
  }
}
