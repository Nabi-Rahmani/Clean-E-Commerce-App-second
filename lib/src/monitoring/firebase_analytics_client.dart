// ignore_for_file: deprecated_member_use_from_same_package

import 'package:e_clean_fcm/src/monitoring/analytics_client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_analytics_client.g.dart';

class FirebaseAnalyticsClient implements AnalyticsClient {
  const FirebaseAnalyticsClient(this._analytics);
  final FirebaseAnalytics _analytics;

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    await _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> identifyUser(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  @override
  Future<void> resetUser() async {
    await _analytics.setUserId(id: null);
  }

  @override
  Future<void> trackScreenView(String routeName, String action) async {
    await _analytics.logScreenView(
        screenName: 'screen_view',
        parameters: {'name': routeName, 'action': action});
  }

  @override
  Future<void> trackNewAppHome() async {
    await _analytics.logEvent(name: 'new_app_home');
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    await _analytics.logEvent(name: 'new_app_onboarding');
  }

  @override
  Future<void> trackAppCreated() async {
    await _analytics.logEvent(name: 'app_created');
  }

  @override
  Future<void> trackAppUpdated() async {
    await _analytics.logEvent(name: 'app_updated');
  }

  @override
  Future<void> trackAppDeleted() async {
    await _analytics.logEvent(name: 'app_deleted');
  }

  @override
  Future<void> trackTaskCompleted(int completedCount) async {
    await _analytics.logEvent(
        name: 'task_completed', parameters: {'count': completedCount});
  }

  @override
  Future<void> trackAppOpened() async {
    await _analytics.logEvent(name: 'trackAppOpened');
  }
}

@Riverpod(keepAlive: true)
FirebaseAnalyticsClient firebaseAnalyticsClient(
    FirebaseAnalyticsClientRef ref) {
  return FirebaseAnalyticsClient(FirebaseAnalytics.instance);
}