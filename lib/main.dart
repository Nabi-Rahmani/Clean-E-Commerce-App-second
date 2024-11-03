import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/core/themes/app_theme_data.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/auth/widgets/stream_atuth.dart';
import 'package:e_clean_fcm/firebase_options.dart';
import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
import 'package:e_clean_fcm/src/monitoring/monitoring/logger_navigator_observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // 1. Enable persistence
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  // 2. Configure settings
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  // Initialize Firebase Analytics
  final analytics = FirebaseAnalytics.instance;
  await analytics.setAnalyticsCollectionEnabled(true);

  await Hive.initFlutter();
  await Hive.openBox('theme_box');

  // Create ProviderContainer inside ProviderScope
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          // Track app opened after ProviderScope is available
          unawaited(ref.read(analyticsFacadeProvider).trackAppOpened());
          return const MyApp();
        },
      ),
    ),
  );
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
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        LoggerNavigatorObserver(ref.read(analyticsFacadeProvider)),
        FirebaseAnalyticsObserver(
          analytics: FirebaseAnalytics.instance,
          nameExtractor: (settings) {
            // Custom naming for your routes
            return settings.name ?? 'unknown_screen';
          },
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
//

// class SignUpProgress extends StatefulWidget {
//   const SignUpProgress({super.key});

//   @override
//   _SignUpProgressState createState() => _SignUpProgressState();
// }

// class _SignUpProgressState extends State<SignUpProgress> {
//   int _currentStep = 1; // Track the current step

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildStepIndicator(1, "Signup"),
//             _buildStepIndicator(2, "Address"),
//             _buildStepIndicator(3, "Verification"),
//           ],
//         ),
//         // Add your form's PageView or content here, controlled by `_currentStep`
//         Expanded(
//           child: PageView(
//             onPageChanged: (index) {
//               setState(() {
//                 _currentStep = index + 1;
//               });
//             },
//             children: const [
//               // Pages for each step
//               Center(child: Text("Signup Form")),
//               Center(child: Text("Address Form")),
//               Center(child: Text("Verification Form")),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStepIndicator(int step, String title) {
//     bool isActive = step == _currentStep;
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 15,
//           backgroundColor: isActive ? Colors.blue : Colors.grey,
//           child: Text(
//             step.toString(),
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           title,
//           style: TextStyle(
//             color: isActive ? Colors.blue : Colors.grey,
//             fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
// }
