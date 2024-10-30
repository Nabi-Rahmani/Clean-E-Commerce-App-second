// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserModels {
  String get userid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  File? get imageFile => throw _privateConstructorUsedError;

  /// Create a copy of UserModels
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelsCopyWith<UserModels> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelsCopyWith<$Res> {
  factory $UserModelsCopyWith(
          UserModels value, $Res Function(UserModels) then) =
      _$UserModelsCopyWithImpl<$Res, UserModels>;
  @useResult
  $Res call(
      {String userid,
      String email,
      String password,
      String userName,
      String lastName,
      String imageUrl,
      DateTime? createdAt,
      File? imageFile});
}

/// @nodoc
class _$UserModelsCopyWithImpl<$Res, $Val extends UserModels>
    implements $UserModelsCopyWith<$Res> {
  _$UserModelsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModels
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userid = null,
    Object? email = null,
    Object? password = null,
    Object? userName = null,
    Object? lastName = null,
    Object? imageUrl = null,
    Object? createdAt = freezed,
    Object? imageFile = freezed,
  }) {
    return _then(_value.copyWith(
      userid: null == userid
          ? _value.userid
          : userid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelsImplCopyWith<$Res>
    implements $UserModelsCopyWith<$Res> {
  factory _$$UserModelsImplCopyWith(
          _$UserModelsImpl value, $Res Function(_$UserModelsImpl) then) =
      __$$UserModelsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userid,
      String email,
      String password,
      String userName,
      String lastName,
      String imageUrl,
      DateTime? createdAt,
      File? imageFile});
}

/// @nodoc
class __$$UserModelsImplCopyWithImpl<$Res>
    extends _$UserModelsCopyWithImpl<$Res, _$UserModelsImpl>
    implements _$$UserModelsImplCopyWith<$Res> {
  __$$UserModelsImplCopyWithImpl(
      _$UserModelsImpl _value, $Res Function(_$UserModelsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModels
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userid = null,
    Object? email = null,
    Object? password = null,
    Object? userName = null,
    Object? lastName = null,
    Object? imageUrl = null,
    Object? createdAt = freezed,
    Object? imageFile = freezed,
  }) {
    return _then(_$UserModelsImpl(
      userid: null == userid
          ? _value.userid
          : userid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$UserModelsImpl implements _UserModels {
  const _$UserModelsImpl(
      {required this.userid,
      required this.email,
      required this.password,
      required this.userName,
      required this.lastName,
      this.imageUrl = '',
      this.createdAt,
      this.imageFile});

  @override
  final String userid;
  @override
  final String email;
  @override
  final String password;
  @override
  final String userName;
  @override
  final String lastName;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  final DateTime? createdAt;
  @override
  final File? imageFile;

  @override
  String toString() {
    return 'UserModels(userid: $userid, email: $email, password: $password, userName: $userName, lastName: $lastName, imageUrl: $imageUrl, createdAt: $createdAt, imageFile: $imageFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelsImpl &&
            (identical(other.userid, userid) || other.userid == userid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userid, email, password,
      userName, lastName, imageUrl, createdAt, imageFile);

  /// Create a copy of UserModels
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelsImplCopyWith<_$UserModelsImpl> get copyWith =>
      __$$UserModelsImplCopyWithImpl<_$UserModelsImpl>(this, _$identity);
}

abstract class _UserModels implements UserModels {
  const factory _UserModels(
      {required final String userid,
      required final String email,
      required final String password,
      required final String userName,
      required final String lastName,
      final String imageUrl,
      final DateTime? createdAt,
      final File? imageFile}) = _$UserModelsImpl;

  @override
  String get userid;
  @override
  String get email;
  @override
  String get password;
  @override
  String get userName;
  @override
  String get lastName;
  @override
  String get imageUrl;
  @override
  DateTime? get createdAt;
  @override
  File? get imageFile;

  /// Create a copy of UserModels
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelsImplCopyWith<_$UserModelsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
