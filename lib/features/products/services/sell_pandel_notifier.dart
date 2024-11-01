// ignore_for_file: avoid_print

import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sell_pandel_notifier.freezed.dart';
part 'sell_pandel_notifier.g.dart';

@freezed
class SellPanelStat with _$SellPanelStat {
  factory SellPanelStat({
    @Default(false) bool isLogin,
    @Default(false) bool isAuthenticaion,
    @Default('') String? proTitle,
    @Default('') String? proDesciption,
    @Default(0.0) double proPrice,
    @Default([]) List<File>? proImageFile,
  }) = _SellPanelStat;
}

@riverpod
class SellPanelNotifier extends _$SellPanelNotifier {
  @override
  SellPanelStat build() => SellPanelStat();
  void toggleisAuthenticaion() {
    state = state.copyWith(isAuthenticaion: !state.isAuthenticaion);
  }

  void toggleAuthMode() {
    state = state.copyWith(isLogin: !state.isLogin);
  }

  void setTitle(String proTitle) {
    print('Setting Title: $proTitle');
    state = state.copyWith(proTitle: proTitle);
  }

  void setDescriptions(String proDesciption) {
    print('Setting Description: $proDesciption');
    state = state.copyWith(proDesciption: proDesciption);
  }

  void setPrice(double proPrice) {
    print('Setting Price: $proPrice');
    state = state.copyWith(proPrice: proPrice);
  }

  // Method to set multiple image files
  void setImageFiles(List<File>? proImageFile) {
    state = state.copyWith(proImageFile: proImageFile);
  }
}
