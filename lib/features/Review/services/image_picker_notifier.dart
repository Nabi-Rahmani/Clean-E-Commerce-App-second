// ignore_for_file: override_on_non_overriding_member

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker_notifier.g.dart';

@riverpod
class ImagePickerReviewNotifier extends _$ImagePickerReviewNotifier {
  @override
  File? build() => null; // Initial state is null

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 70,
      );

      if (pickedImage != null) {
        state = File(pickedImage.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void clearImage() {
    state = null;
  }
}
