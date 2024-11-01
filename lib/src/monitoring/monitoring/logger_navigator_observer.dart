// ignore_for_file: unused_field

import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class LoggerNavigatorObserver extends NavigatorObserver {
  LoggerNavigatorObserver(this._analytics);
  final AnalyticsFacade _analytics;
  static const _name = 'Navigation';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logNavigation(route.settings.name, 'push');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logNavigation(route.settings.name, 'pop');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _logNavigation(newRoute.settings.name, 'replace');
    }
  }

  void _logNavigation(String? routeName, String action) {
    if (routeName != null) {
      log("Screen $action: $routeName", name: _name);
    } else {
      log('Route name is missing', name: _name);
    }
  }
}
