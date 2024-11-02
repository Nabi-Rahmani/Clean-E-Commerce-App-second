// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'textfeild_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TextFieldStates {
  String? get textFielController => throw _privateConstructorUsedError;

  /// Create a copy of TextFieldStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextFieldStatesCopyWith<TextFieldStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextFieldStatesCopyWith<$Res> {
  factory $TextFieldStatesCopyWith(
          TextFieldStates value, $Res Function(TextFieldStates) then) =
      _$TextFieldStatesCopyWithImpl<$Res, TextFieldStates>;
  @useResult
  $Res call({String? textFielController});
}

/// @nodoc
class _$TextFieldStatesCopyWithImpl<$Res, $Val extends TextFieldStates>
    implements $TextFieldStatesCopyWith<$Res> {
  _$TextFieldStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextFieldStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textFielController = freezed,
  }) {
    return _then(_value.copyWith(
      textFielController: freezed == textFielController
          ? _value.textFielController
          : textFielController // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextFieldStatesImplCopyWith<$Res>
    implements $TextFieldStatesCopyWith<$Res> {
  factory _$$TextFieldStatesImplCopyWith(_$TextFieldStatesImpl value,
          $Res Function(_$TextFieldStatesImpl) then) =
      __$$TextFieldStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? textFielController});
}

/// @nodoc
class __$$TextFieldStatesImplCopyWithImpl<$Res>
    extends _$TextFieldStatesCopyWithImpl<$Res, _$TextFieldStatesImpl>
    implements _$$TextFieldStatesImplCopyWith<$Res> {
  __$$TextFieldStatesImplCopyWithImpl(
      _$TextFieldStatesImpl _value, $Res Function(_$TextFieldStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of TextFieldStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textFielController = freezed,
  }) {
    return _then(_$TextFieldStatesImpl(
      textFielController: freezed == textFielController
          ? _value.textFielController
          : textFielController // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TextFieldStatesImpl implements _TextFieldStates {
  _$TextFieldStatesImpl({this.textFielController = 'defaultValue'});

  @override
  @JsonKey()
  final String? textFielController;

  @override
  String toString() {
    return 'TextFieldStates(textFielController: $textFielController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextFieldStatesImpl &&
            (identical(other.textFielController, textFielController) ||
                other.textFielController == textFielController));
  }

  @override
  int get hashCode => Object.hash(runtimeType, textFielController);

  /// Create a copy of TextFieldStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextFieldStatesImplCopyWith<_$TextFieldStatesImpl> get copyWith =>
      __$$TextFieldStatesImplCopyWithImpl<_$TextFieldStatesImpl>(
          this, _$identity);
}

abstract class _TextFieldStates implements TextFieldStates {
  factory _TextFieldStates({final String? textFielController}) =
      _$TextFieldStatesImpl;

  @override
  String? get textFielController;

  /// Create a copy of TextFieldStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextFieldStatesImplCopyWith<_$TextFieldStatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
