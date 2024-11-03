// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddressStates {
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  /// Create a copy of AddressStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressStatesCopyWith<AddressStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressStatesCopyWith<$Res> {
  factory $AddressStatesCopyWith(
          AddressStates value, $Res Function(AddressStates) then) =
      _$AddressStatesCopyWithImpl<$Res, AddressStates>;
  @useResult
  $Res call(
      {String? city,
      String? district,
      String? neighborhood,
      String? address,
      String? title});
}

/// @nodoc
class _$AddressStatesCopyWithImpl<$Res, $Val extends AddressStates>
    implements $AddressStatesCopyWith<$Res> {
  _$AddressStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? address = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressStatesImplCopyWith<$Res>
    implements $AddressStatesCopyWith<$Res> {
  factory _$$AddressStatesImplCopyWith(
          _$AddressStatesImpl value, $Res Function(_$AddressStatesImpl) then) =
      __$$AddressStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? city,
      String? district,
      String? neighborhood,
      String? address,
      String? title});
}

/// @nodoc
class __$$AddressStatesImplCopyWithImpl<$Res>
    extends _$AddressStatesCopyWithImpl<$Res, _$AddressStatesImpl>
    implements _$$AddressStatesImplCopyWith<$Res> {
  __$$AddressStatesImplCopyWithImpl(
      _$AddressStatesImpl _value, $Res Function(_$AddressStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? address = freezed,
    Object? title = freezed,
  }) {
    return _then(_$AddressStatesImpl(
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AddressStatesImpl implements _AddressStates {
  _$AddressStatesImpl(
      {this.city, this.district, this.neighborhood, this.address, this.title});

  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? neighborhood;
  @override
  final String? address;
  @override
  final String? title;

  @override
  String toString() {
    return 'AddressStates(city: $city, district: $district, neighborhood: $neighborhood, address: $address, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressStatesImpl &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, city, district, neighborhood, address, title);

  /// Create a copy of AddressStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressStatesImplCopyWith<_$AddressStatesImpl> get copyWith =>
      __$$AddressStatesImplCopyWithImpl<_$AddressStatesImpl>(this, _$identity);
}

abstract class _AddressStates implements AddressStates {
  factory _AddressStates(
      {final String? city,
      final String? district,
      final String? neighborhood,
      final String? address,
      final String? title}) = _$AddressStatesImpl;

  @override
  String? get city;
  @override
  String? get district;
  @override
  String? get neighborhood;
  @override
  String? get address;
  @override
  String? get title;

  /// Create a copy of AddressStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressStatesImplCopyWith<_$AddressStatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
