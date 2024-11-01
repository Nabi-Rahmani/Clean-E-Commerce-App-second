import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker_notifier.freezed.dart';
part 'image_picker_notifier.g.dart';

@freezed
class AutoStatImagePicker with _$AutoStatImagePicker {
  factory AutoStatImagePicker({
    File? imageFile,
  }) = _AutoStatImagePicker;
}

@riverpod
class AutoStatImagePickerNotifier extends _$AutoStatImagePickerNotifier {
  @override
  AutoStatImagePicker build() => AutoStatImagePicker();

  void setImageFile(File? imageFile) {
    state = state.copyWith(imageFile: imageFile);
  }
}
