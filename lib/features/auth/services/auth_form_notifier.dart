// auth_form_notifier.dart
import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_form_notifier.g.dart';
part 'auth_form_notifier.freezed.dart';

@freezed
class AuthFormState with _$AuthFormState {
  const factory AuthFormState({
    @Default(false) bool isLogin,
    @Default(false) bool isAuthenticaion,
    @Default('') String? email,
    @Default('') String? password,
    @Default('') String? userName,
    @Default('') String? lastName,
    File? imageFile,
  }) = _AuthFormState;
}

@riverpod
class AuthFormNotifier extends _$AuthFormNotifier {
  @override
  AuthFormState build() => const AuthFormState();
  void toggleisAuthenticaion() {
    state = state.copyWith(isAuthenticaion: !state.isAuthenticaion);
  }

  void toggleAuthMode() {
    state = state.copyWith(isLogin: !state.isLogin);
  }

  void setEmail(String email) {
    print('Setting email: $email');
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    print('Setting passwrod: $password');
    state = state.copyWith(password: password);
  }

  void setUserName(String userName) {
    print('Setting UserName: $userName');
    state = state.copyWith(userName: userName);
  }

  void setLastName(String lastName) {
    print('Setting LastName: $lastName');
    state = state.copyWith(lastName: lastName);
  }

  void setImageFile(File? imageFile) {
    state = state.copyWith(imageFile: imageFile);
  }
}
