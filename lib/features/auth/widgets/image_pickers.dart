// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'package:e_clean_fcm/core/constants/app_const_colors.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends ConsumerStatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onPickedImageFile,
  });

  final void Function(File pickImageFile) onPickedImageFile;

  @override
  ConsumerState<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends ConsumerState<UserImagePicker> {
  File? _pickedImageFile;

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(ctx);
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 100,
                  maxHeight: 100,
                  maxWidth: 100,
                );
                if (pickedImage == null) {
                  return;
                }
                setState(() {
                  _pickedImageFile = File(pickedImage.path);
                });
                widget.onPickedImageFile(_pickedImageFile!);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(ctx);
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                  maxHeight: 600,
                  maxWidth: 600,
                );
                if (pickedImage == null) {
                  return;
                }
                setState(() {
                  _pickedImageFile = File(pickedImage.path);
                });
                widget.onPickedImageFile(_pickedImageFile!);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final IsDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.greyShade200(true)),
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundColor: IsDarkMode ? AppColors.heart : Colors.black,
                radius: 50,
                foregroundImage: _pickedImageFile != null
                    ? FileImage(_pickedImageFile!)
                    : null,
                child: Icon(
                  Icons.person,
                  color: AppColors.greyShade200(true),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: -1,
              child: GestureDetector(
                onTap: _showImagePicker,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: IsDarkMode ? Colors.black45 : Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: AppColors.greyShade200(true),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
