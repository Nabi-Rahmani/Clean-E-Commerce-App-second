import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';

@freezed
class UserModels with _$UserModels {
  const factory UserModels({
    required String userid,
    required String email,
    required String password,
    required String userName,
    required String lastName,
    @Default('') String imageUrl,
    DateTime? createdAt,
    File? imageFile,
  }) = _UserModels;
}
