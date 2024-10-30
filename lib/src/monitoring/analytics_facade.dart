import 'package:e_clean_fcm/src/monitoring/analytics_client.dart';
import 'package:e_clean_fcm/src/monitoring/firebase_analytics_client.dart';
import 'package:e_clean_fcm/src/monitoring/logger_analytics_client.dart';
import 'package:flutter/foundation.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'analytics_facade.g.dart';

// https://refactoring.guru/design-patterns/facade
class AnalyticsFacade implements AnalyticsClient {
  const AnalyticsFacade(this.clients);
  final List<AnalyticsClient> clients;

  @override
  Future<void> trackAppOpened() => _dispatch(
        (c) => c.trackAppOpened(),
      );

  @override
  Future<void> trackNewAppHome() => _dispatch(
        (c) => c.trackNewAppHome(),
      );

  @override
  Future<void> trackNewAppOnboarding() => _dispatch(
        (c) => c.trackNewAppOnboarding(),
      );

  @override
  Future<void> trackAppCreated() => _dispatch(
        (c) => c.trackAppCreated(),
      );

  @override
  Future<void> trackAppUpdated() => _dispatch(
        (c) => c.trackAppUpdated(),
      );

  @override
  Future<void> trackAppDeleted() => _dispatch(
        (c) => c.trackAppDeleted(),
      );

  @override
  Future<void> trackTaskCompleted(int completedCount) => _dispatch(
        (c) => c.trackTaskCompleted(completedCount),
      );

  Future<void> _dispatch(
      Future<void> Function(AnalyticsClient client) work) async {
    for (var client in clients) {
      await work(client);
    }
  }

  @override
  Future<void> identifyUser(String userId) => _dispatch(
        (c) => c.identifyUser(userId),
      );

  @override
  Future<void> resetUser() => _dispatch((c) => c.resetUser());

  @override
  Future<void> trackScreenView(String routeName, String action) => _dispatch(
        (c) => c.trackScreenView(routeName, action),
      );
}

@Riverpod(keepAlive: true)
AnalyticsFacade analyticsFacade(ref) {
  final firebaseAnalyticsClient = ref.watch(firebaseAnalyticsClientProvider);
  // final mixpanelAnalyticsClient =
  //     ref.watch(mixpanelAnalyticsClientProvider).requireValue;
  return AnalyticsFacade([
    firebaseAnalyticsClient,
    // mixpanelAnalyticsClient,
    if (!kReleaseMode) const LoggerAnalyticsClient(),
  ]);
}
