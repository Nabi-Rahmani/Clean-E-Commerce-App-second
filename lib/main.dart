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

// Simple Rating Example without any complex code
class SimpleRatingExample extends StatefulWidget {
  const SimpleRatingExample({super.key});

  @override
  State<SimpleRatingExample> createState() => _SimpleRatingExampleState();
}

class _SimpleRatingExampleState extends State<SimpleRatingExample> {
  // Simple variables to store our rating data
  double averageRating = 0.0;
  int totalReviews = 0;

  // Store all ratings to show distribution
  List<int> ratings = [];

  // Currently selected rating by user
  int selectedRating = 0;

  // Submit a new rating
  void submitRating(int rating) {
    setState(() {
      // Add new rating to list
      ratings.add(rating);

      // Update total number of reviews
      totalReviews = ratings.length;

      // Calculate new average
      double sum = ratings.fold(0, (prev, curr) => prev + curr);
      averageRating = sum / totalReviews;

      // Reset selected rating
      selectedRating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Rating Demo')),
      body: Column(
        children: [
          // Show current average rating
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Average Rating: ${averageRating.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text('Total Reviews: $totalReviews'),
                ],
              ),
            ),
          ),

          // Rating distribution
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Rating Distribution:',
                      style: TextStyle(fontSize: 18)),
                  ...List.generate(5, (index) {
                    int star = 5 - index;
                    int count = ratings.where((r) => r == star).length;

                    return Row(
                      children: [
                        Text('$star stars: '),
                        Text('$count reviews'),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),

          // Select rating
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Rate this product:',
                      style: TextStyle(fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: selectedRating == 0
                        ? null
                        : () => submitRating(selectedRating),
                    child: const Text('Submit Rating'),
                  ),
                ],
              ),
            ),
          ),

          // Show last 3 ratings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Recent Ratings:', style: TextStyle(fontSize: 18)),
                  ...ratings.reversed.take(3).map(
                        (rating) => Row(
                          children: [
                            ...List.generate(
                                5,
                                (index) => Icon(
                                      index < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 16,
                                      color: Colors.amber,
                                    )),
                          ],
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
