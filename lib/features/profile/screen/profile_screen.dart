import 'dart:async';

import 'package:e_clean_fcm/core/constants/app_const_colors.dart';
import 'package:e_clean_fcm/core/constants/app_sizes.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/shared/custom_buttons.dart';
import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_clean_fcm/core/util/string_hardcode.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
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
            ),
          ),
          Positioned(
            top: 250, // Position it right below the top section
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
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
                            unawaited(ref
                                .read(analyticsFacadeProvider)
                                .trackAppUpdated());
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
                  AppButtons.primary(
                      text: 'Log Out',
                      onTap: () {
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
