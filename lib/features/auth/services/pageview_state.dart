import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'pageview_state.freezed.dart';
part 'pageview_state.g.dart';

@freezed
class PageState with _$PageState {
  factory PageState({
    @Default(1) int currentStep,
  }) = _PageState;
}

@riverpod
class PageNotifier extends _$PageNotifier {
  @override
  PageState build() => PageState();
  void nextStep() {
    if (state.currentStep < 3) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }
}
