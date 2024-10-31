// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_picker_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AutoStatImagePicker {
  File? get imageFile => throw _privateConstructorUsedError;

  /// Create a copy of AutoStatImagePicker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AutoStatImagePickerCopyWith<AutoStatImagePicker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoStatImagePickerCopyWith<$Res> {
  factory $AutoStatImagePickerCopyWith(
          AutoStatImagePicker value, $Res Function(AutoStatImagePicker) then) =
      _$AutoStatImagePickerCopyWithImpl<$Res, AutoStatImagePicker>;
  @useResult
  $Res call({File? imageFile});
}

/// @nodoc
class _$AutoStatImagePickerCopyWithImpl<$Res, $Val extends AutoStatImagePicker>
    implements $AutoStatImagePickerCopyWith<$Res> {
  _$AutoStatImagePickerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AutoStatImagePicker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageFile = freezed,
  }) {
    return _then(_value.copyWith(
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AutoStatImagePickerImplCopyWith<$Res>
    implements $AutoStatImagePickerCopyWith<$Res> {
  factory _$$AutoStatImagePickerImplCopyWith(_$AutoStatImagePickerImpl value,
          $Res Function(_$AutoStatImagePickerImpl) then) =
      __$$AutoStatImagePickerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? imageFile});
}

/// @nodoc
class __$$AutoStatImagePickerImplCopyWithImpl<$Res>
    extends _$AutoStatImagePickerCopyWithImpl<$Res, _$AutoStatImagePickerImpl>
    implements _$$AutoStatImagePickerImplCopyWith<$Res> {
  __$$AutoStatImagePickerImplCopyWithImpl(_$AutoStatImagePickerImpl _value,
      $Res Function(_$AutoStatImagePickerImpl) _then)
      : super(_value, _then);

  /// Create a copy of AutoStatImagePicker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageFile = freezed,
  }) {
    return _then(_$AutoStatImagePickerImpl(
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$AutoStatImagePickerImpl implements _AutoStatImagePicker {
  _$AutoStatImagePickerImpl({this.imageFile});

  @override
  final File? imageFile;

  @override
  String toString() {
    return 'AutoStatImagePicker(imageFile: $imageFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoStatImagePickerImpl &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageFile);

  /// Create a copy of AutoStatImagePicker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoStatImagePickerImplCopyWith<_$AutoStatImagePickerImpl> get copyWith =>
      __$$AutoStatImagePickerImplCopyWithImpl<_$AutoStatImagePickerImpl>(
          this, _$identity);
}

abstract class _AutoStatImagePicker implements AutoStatImagePicker {
  factory _AutoStatImagePicker({final File? imageFile}) =
      _$AutoStatImagePickerImpl;

  @override
  File? get imageFile;

  /// Create a copy of AutoStatImagePicker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AutoStatImagePickerImplCopyWith<_$AutoStatImagePickerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
