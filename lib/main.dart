import 'dart:async';

import 'package:e_clean_fcm/core/themes/app_theme_data.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/auth/widgets/stream_atuth.dart';
import 'package:e_clean_fcm/firebase_options.dart';
import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
import 'package:e_clean_fcm/src/monitoring/monitoring/logger_navigator_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox('theme_box');
  final container = ProviderContainer();
  final analytics = container.read(analyticsFacadeProvider);
  unawaited(analytics.trackAppOpened());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeModeNotifierProvider);
    return MaterialApp(
      theme: AppThemeData.light(),
      darkTheme: AppThemeData.dark(),
      themeMode: theme,
      home: const StreamAuth(),
      navigatorObservers: [
        LoggerNavigatorObserver(ref.read(analyticsFacadeProvider)),
      ],
    );
  }
}
