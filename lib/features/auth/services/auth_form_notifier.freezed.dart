// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthFormState {
  bool get isLogin => throw _privateConstructorUsedError;
  bool get isAuthenticaion => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  File? get imageFile => throw _privateConstructorUsedError;

  /// Create a copy of AuthFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthFormStateCopyWith<AuthFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFormStateCopyWith<$Res> {
  factory $AuthFormStateCopyWith(
          AuthFormState value, $Res Function(AuthFormState) then) =
      _$AuthFormStateCopyWithImpl<$Res, AuthFormState>;
  @useResult
  $Res call(
      {bool isLogin,
      bool isAuthenticaion,
      String? email,
      String? password,
      String? userName,
      String? lastName,
      File? imageFile});
}

/// @nodoc
class _$AuthFormStateCopyWithImpl<$Res, $Val extends AuthFormState>
    implements $AuthFormStateCopyWith<$Res> {
  _$AuthFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLogin = null,
    Object? isAuthenticaion = null,
    Object? email = freezed,
    Object? password = freezed,
    Object? userName = freezed,
    Object? lastName = freezed,
    Object? imageFile = freezed,
  }) {
    return _then(_value.copyWith(
      isLogin: null == isLogin
          ? _value.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticaion: null == isAuthenticaion
          ? _value.isAuthenticaion
          : isAuthenticaion // ignore: cast_nullable_to_non_nullable
              as bool,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthFormStateImplCopyWith<$Res>
    implements $AuthFormStateCopyWith<$Res> {
  factory _$$AuthFormStateImplCopyWith(
          _$AuthFormStateImpl value, $Res Function(_$AuthFormStateImpl) then) =
      __$$AuthFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLogin,
      bool isAuthenticaion,
      String? email,
      String? password,
      String? userName,
      String? lastName,
      File? imageFile});
}

/// @nodoc
class __$$AuthFormStateImplCopyWithImpl<$Res>
    extends _$AuthFormStateCopyWithImpl<$Res, _$AuthFormStateImpl>
    implements _$$AuthFormStateImplCopyWith<$Res> {
  __$$AuthFormStateImplCopyWithImpl(
      _$AuthFormStateImpl _value, $Res Function(_$AuthFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLogin = null,
    Object? isAuthenticaion = null,
    Object? email = freezed,
    Object? password = freezed,
    Object? userName = freezed,
    Object? lastName = freezed,
    Object? imageFile = freezed,
  }) {
    return _then(_$AuthFormStateImpl(
      isLogin: null == isLogin
          ? _value.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticaion: null == isAuthenticaion
          ? _value.isAuthenticaion
          : isAuthenticaion // ignore: cast_nullable_to_non_nullable
              as bool,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$AuthFormStateImpl implements _AuthFormState {
  const _$AuthFormStateImpl(
      {this.isLogin = false,
      this.isAuthenticaion = false,
      this.email = '',
      this.password = '',
      this.userName = '',
      this.lastName = '',
      this.imageFile});

  @override
  @JsonKey()
  final bool isLogin;
  @override
  @JsonKey()
  final bool isAuthenticaion;
  @override
  @JsonKey()
  final String? email;
  @override
  @JsonKey()
  final String? password;
  @override
  @JsonKey()
  final String? userName;
  @override
  @JsonKey()
  final String? lastName;
  @override
  final File? imageFile;

  @override
  String toString() {
    return 'AuthFormState(isLogin: $isLogin, isAuthenticaion: $isAuthenticaion, email: $email, password: $password, userName: $userName, lastName: $lastName, imageFile: $imageFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFormStateImpl &&
            (identical(other.isLogin, isLogin) || other.isLogin == isLogin) &&
            (identical(other.isAuthenticaion, isAuthenticaion) ||
                other.isAuthenticaion == isAuthenticaion) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLogin, isAuthenticaion, email,
      password, userName, lastName, imageFile);

  /// Create a copy of AuthFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFormStateImplCopyWith<_$AuthFormStateImpl> get copyWith =>
      __$$AuthFormStateImplCopyWithImpl<_$AuthFormStateImpl>(this, _$identity);
}

abstract class _AuthFormState implements AuthFormState {
  const factory _AuthFormState(
      {final bool isLogin,
      final bool isAuthenticaion,
      final String? email,
      final String? password,
      final String? userName,
      final String? lastName,
      final File? imageFile}) = _$AuthFormStateImpl;

  @override
  bool get isLogin;
  @override
  bool get isAuthenticaion;
  @override
  String? get email;
  @override
  String? get password;
  @override
  String? get userName;
  @override
  String? get lastName;
  @override
  File? get imageFile;

  /// Create a copy of AuthFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthFormStateImplCopyWith<_$AuthFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
