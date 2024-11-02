import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'textfeild_state.freezed.dart';
part 'textfeild_state.g.dart';

@freezed
class TextFieldStates with _$TextFieldStates {
  factory TextFieldStates({
    @Default('defaultValue') String? textFielController,
  }) = _TextFieldStates;
}

@riverpod
class TextFieldNotifier extends _$TextFieldNotifier {
  @override
  TextFieldStates build() => TextFieldStates();

  void setTextControler(String? textControler) {
    state = state.copyWith(textFielController: textControler);
  }
}
