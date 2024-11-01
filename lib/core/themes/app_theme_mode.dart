// // lib/core/themes/app_theme_mode.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// // Add this line to generate the part file
part 'app_theme_mode.g.dart';

// @riverpod
// class AppThemeModeNotifier extends _$AppThemeModeNotifier {
//   static const key = 'app_theme_mode';

//   Box get _box => Hive.box('theme_box');

//   @override
//   ThemeMode build() {
//     final themeModeStr = _box.get(key, defaultValue: 'system');
//     return switch (themeModeStr) {
//       'light' => ThemeMode.light,
//       'dark' => ThemeMode.dark,
//       'system' || _ => ThemeMode.system,
//     };
//   }

//   void setThemeMode(ThemeMode mode) {
//     _box.put(key, mode.name);
//     state = mode; // Update state directly instead of invalidateSelf
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'app_theme_mode_notifier.g.dart';

@riverpod
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  static const key = 'app_theme_mode';

  Box get _box => Hive.box('theme_box');

  @override
  ThemeMode build() {
    final themeModeStr = _box.get(key, defaultValue: 'system');
    return switch (themeModeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' || _ => ThemeMode.system,
    };
  }

  void setThemeMode(ThemeMode mode) {
    _box.put(key, mode.name);
    state = mode; // Update state directly
  }

  // Computed property to check if dark mode is enabled
  bool get isDarkMode {
    return state == ThemeMode.dark ||
        (state == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);
  }
}
