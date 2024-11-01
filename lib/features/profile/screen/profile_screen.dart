// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:e_clean_fcm/core/constants/app_const_colors.dart';
import 'package:e_clean_fcm/core/constants/app_sizes.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/auth/services/auth_notifier.dart';
import 'package:e_clean_fcm/features/products/widgets/sellpanel.dart';
import 'package:e_clean_fcm/features/profile/services/image_picker_notifier.dart';
import 'package:e_clean_fcm/features/profile/widgets/get_user_data.dart';
import 'package:e_clean_fcm/shared/custom_buttons.dart';
import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
import 'package:e_clean_fcm/src/monitoring/firebase_analytics_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_clean_fcm/core/util/string_hardcode.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showImagePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text('Camera'.hardcoded),
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

                ref
                    .read(autoStatImagePickerNotifierProvider.notifier)
                    .setImageFile(File(pickedImage.path));
                updateUserProfiel(ref);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('Gallery'.hardcoded),
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
                ref
                    .read(autoStatImagePickerNotifierProvider.notifier)
                    .setImageFile(File(pickedImage.path));
                updateUserProfiel(ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserProfiel(WidgetRef ref) async {
    final autoImage = ref.read(autoStatImagePickerNotifierProvider);
    final auth = ref.watch(authNotifierProvider.notifier);
    try {
      await auth.updateUserProfile(newProfileImage: autoImage.imageFile!);
    } catch (e) {
      print('error when updating user profile image:$e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackUser = ref.watch(analyticsFacadeProvider);
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    trackUser.trackScreenView('/your_screen', 'view');
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                ),
                color: AppColors.primary,
              ),
              child: const Column(
                children: [
                  Expanded(child: GetUserDetails()),
                ],
              ),
            ),
          ),
          Positioned(
            top: 250, // Position it right below the top section
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Sizes.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Theme mode'.hardcoded),
                        gapH8,
                        SegmentedButton<ThemeMode>(
                          multiSelectionEnabled: false,
                          emptySelectionAllowed: false,
                          showSelectedIcon: false,
                          selected: {themeMode},
                          onSelectionChanged: (Set<ThemeMode> newSelection) {
                            ref
                                .read(appThemeModeNotifierProvider.notifier)
                                // ignore:avoid-unsafe-collection-methods
                                .setThemeMode(newSelection.single);
                          },
                          segments: ThemeMode.values
                              .map<ButtonSegment<ThemeMode>>((ThemeMode theme) {
                            // Capitalize first letter
                            final label = theme.name[0].toUpperCase() +
                                theme.name.substring(1);
                            return ButtonSegment<ThemeMode>(
                              value: theme,
                              label: Text(label),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text('Change Profile'.hardcoded),
                    leading: const Icon(
                      Icons.add_a_photo,
                    ),
                    onTap: () {
                      unawaited(trackUser.trackAppUpdated());
                      _showImagePicker(context, ref);
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.sell),
                    title: Text('SellPanel'.hardcoded),
                    onTap: () {
                      unawaited(trackUser.trackAppCreated());
                      showSellPanel(context);
                    },
                  ),
                  AppButtons.primary(
                      text: 'Log Out'.hardcoded,
                      onTap: () {
                        trackUser.trackTaskCompleted(1);
                        FirebaseAuth.instance.signOut();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
