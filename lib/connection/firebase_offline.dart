// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_offline.g.dart';

@riverpod
class ConnectivityService extends _$ConnectivityService {
  @override
  Stream<bool> build() {
    return Connectivity()
        .onConnectivityChanged
        .map((status) => status != ConnectivityResult.none);
  }

  Future<bool> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
