import 'dart:developer';

import 'package:e_clean_fcm/src/monitoring/analytics_client.dart';

class LoggerAnalyticsClient implements AnalyticsClient {
  const LoggerAnalyticsClient();
  static const _name = 'Event';
  @override
  Future<void> trackAppOpened() async {
    log('trackAppOpened');
  }

  @override
  Future<void> trackNewAppHome() async {
    log('trackNewAppHome');
  }

  @override
  Future<void> trackNewAppOnboarding() async {
    log('trackNewAppOnboarding');
  }

  @override
  Future<void> trackAppCreated() async {
    log('trackAppCreated');
  }

  @override
  Future<void> trackAppUpdated() async {
    log('trackAppUpdated');
  }

  @override
  Future<void> trackAppDeleted() async {
    log('trackAppDeleted');
  }

  @override
  Future<void> trackTaskCompleted(int completedCount) async {
    log('trackTaskCompleted(completedCount: $completedCount)');
  }

  @override
  Future<void> identifyUser(String userId) async {
    log('useridenty ($userId)', name: _name);
  }

  @override
  Future<void> resetUser() async {
    log('resetUser', name: _name);
  }
}
