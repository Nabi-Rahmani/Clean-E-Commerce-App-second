// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddressModeles {
  String get city => throw _privateConstructorUsedError;
  String get district => throw _privateConstructorUsedError;
  String get neighborhood => throw _privateConstructorUsedError;
  String get addresses => throw _privateConstructorUsedError;
  String get adressTitle => throw _privateConstructorUsedError;

  /// Create a copy of AddressModeles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressModelesCopyWith<AddressModeles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelesCopyWith<$Res> {
  factory $AddressModelesCopyWith(
          AddressModeles value, $Res Function(AddressModeles) then) =
      _$AddressModelesCopyWithImpl<$Res, AddressModeles>;
  @useResult
  $Res call(
      {String city,
      String district,
      String neighborhood,
      String addresses,
      String adressTitle});
}

/// @nodoc
class _$AddressModelesCopyWithImpl<$Res, $Val extends AddressModeles>
    implements $AddressModelesCopyWith<$Res> {
  _$AddressModelesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressModeles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = null,
    Object? district = null,
    Object? neighborhood = null,
    Object? addresses = null,
    Object? adressTitle = null,
  }) {
    return _then(_value.copyWith(
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: null == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String,
      addresses: null == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as String,
      adressTitle: null == adressTitle
          ? _value.adressTitle
          : adressTitle // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressModelesImplCopyWith<$Res>
    implements $AddressModelesCopyWith<$Res> {
  factory _$$AddressModelesImplCopyWith(_$AddressModelesImpl value,
          $Res Function(_$AddressModelesImpl) then) =
      __$$AddressModelesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String city,
      String district,
      String neighborhood,
      String addresses,
      String adressTitle});
}

/// @nodoc
class __$$AddressModelesImplCopyWithImpl<$Res>
    extends _$AddressModelesCopyWithImpl<$Res, _$AddressModelesImpl>
    implements _$$AddressModelesImplCopyWith<$Res> {
  __$$AddressModelesImplCopyWithImpl(
      _$AddressModelesImpl _value, $Res Function(_$AddressModelesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressModeles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = null,
    Object? district = null,
    Object? neighborhood = null,
    Object? addresses = null,
    Object? adressTitle = null,
  }) {
    return _then(_$AddressModelesImpl(
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: null == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String,
      addresses: null == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as String,
      adressTitle: null == adressTitle
          ? _value.adressTitle
          : adressTitle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddressModelesImpl implements _AddressModeles {
  _$AddressModelesImpl(
      {required this.city,
      required this.district,
      required this.neighborhood,
      required this.addresses,
      required this.adressTitle});

  @override
  final String city;
  @override
  final String district;
  @override
  final String neighborhood;
  @override
  final String addresses;
  @override
  final String adressTitle;

  @override
  String toString() {
    return 'AddressModeles(city: $city, district: $district, neighborhood: $neighborhood, addresses: $addresses, adressTitle: $adressTitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressModelesImpl &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.addresses, addresses) ||
                other.addresses == addresses) &&
            (identical(other.adressTitle, adressTitle) ||
                other.adressTitle == adressTitle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, city, district, neighborhood, addresses, adressTitle);

  /// Create a copy of AddressModeles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressModelesImplCopyWith<_$AddressModelesImpl> get copyWith =>
      __$$AddressModelesImplCopyWithImpl<_$AddressModelesImpl>(
          this, _$identity);
}

abstract class _AddressModeles implements AddressModeles {
  factory _AddressModeles(
      {required final String city,
      required final String district,
      required final String neighborhood,
      required final String addresses,
      required final String adressTitle}) = _$AddressModelesImpl;

  @override
  String get city;
  @override
  String get district;
  @override
  String get neighborhood;
  @override
  String get addresses;
  @override
  String get adressTitle;

  /// Create a copy of AddressModeles
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressModelesImplCopyWith<_$AddressModelesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
