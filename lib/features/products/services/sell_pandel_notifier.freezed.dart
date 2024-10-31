// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sell_pandel_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SellPanelStat {
  bool get isLogin => throw _privateConstructorUsedError;
  bool get isAuthenticaion => throw _privateConstructorUsedError;
  String? get proTitle => throw _privateConstructorUsedError;
  String? get proDesciption => throw _privateConstructorUsedError;
  double get proPrice => throw _privateConstructorUsedError;
  List<File>? get proImageFile => throw _privateConstructorUsedError;

  /// Create a copy of SellPanelStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SellPanelStatCopyWith<SellPanelStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellPanelStatCopyWith<$Res> {
  factory $SellPanelStatCopyWith(
          SellPanelStat value, $Res Function(SellPanelStat) then) =
      _$SellPanelStatCopyWithImpl<$Res, SellPanelStat>;
  @useResult
  $Res call(
      {bool isLogin,
      bool isAuthenticaion,
      String? proTitle,
      String? proDesciption,
      double proPrice,
      List<File>? proImageFile});
}

/// @nodoc
class _$SellPanelStatCopyWithImpl<$Res, $Val extends SellPanelStat>
    implements $SellPanelStatCopyWith<$Res> {
  _$SellPanelStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SellPanelStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLogin = null,
    Object? isAuthenticaion = null,
    Object? proTitle = freezed,
    Object? proDesciption = freezed,
    Object? proPrice = null,
    Object? proImageFile = freezed,
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
      proTitle: freezed == proTitle
          ? _value.proTitle
          : proTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      proDesciption: freezed == proDesciption
          ? _value.proDesciption
          : proDesciption // ignore: cast_nullable_to_non_nullable
              as String?,
      proPrice: null == proPrice
          ? _value.proPrice
          : proPrice // ignore: cast_nullable_to_non_nullable
              as double,
      proImageFile: freezed == proImageFile
          ? _value.proImageFile
          : proImageFile // ignore: cast_nullable_to_non_nullable
              as List<File>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SellPanelStatImplCopyWith<$Res>
    implements $SellPanelStatCopyWith<$Res> {
  factory _$$SellPanelStatImplCopyWith(
          _$SellPanelStatImpl value, $Res Function(_$SellPanelStatImpl) then) =
      __$$SellPanelStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLogin,
      bool isAuthenticaion,
      String? proTitle,
      String? proDesciption,
      double proPrice,
      List<File>? proImageFile});
}

/// @nodoc
class __$$SellPanelStatImplCopyWithImpl<$Res>
    extends _$SellPanelStatCopyWithImpl<$Res, _$SellPanelStatImpl>
    implements _$$SellPanelStatImplCopyWith<$Res> {
  __$$SellPanelStatImplCopyWithImpl(
      _$SellPanelStatImpl _value, $Res Function(_$SellPanelStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of SellPanelStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLogin = null,
    Object? isAuthenticaion = null,
    Object? proTitle = freezed,
    Object? proDesciption = freezed,
    Object? proPrice = null,
    Object? proImageFile = freezed,
  }) {
    return _then(_$SellPanelStatImpl(
      isLogin: null == isLogin
          ? _value.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticaion: null == isAuthenticaion
          ? _value.isAuthenticaion
          : isAuthenticaion // ignore: cast_nullable_to_non_nullable
              as bool,
      proTitle: freezed == proTitle
          ? _value.proTitle
          : proTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      proDesciption: freezed == proDesciption
          ? _value.proDesciption
          : proDesciption // ignore: cast_nullable_to_non_nullable
              as String?,
      proPrice: null == proPrice
          ? _value.proPrice
          : proPrice // ignore: cast_nullable_to_non_nullable
              as double,
      proImageFile: freezed == proImageFile
          ? _value._proImageFile
          : proImageFile // ignore: cast_nullable_to_non_nullable
              as List<File>?,
    ));
  }
}

/// @nodoc

class _$SellPanelStatImpl implements _SellPanelStat {
  _$SellPanelStatImpl(
      {this.isLogin = false,
      this.isAuthenticaion = false,
      this.proTitle = '',
      this.proDesciption = '',
      this.proPrice = 0.0,
      final List<File>? proImageFile = const []})
      : _proImageFile = proImageFile;

  @override
  @JsonKey()
  final bool isLogin;
  @override
  @JsonKey()
  final bool isAuthenticaion;
  @override
  @JsonKey()
  final String? proTitle;
  @override
  @JsonKey()
  final String? proDesciption;
  @override
  @JsonKey()
  final double proPrice;
  final List<File>? _proImageFile;
  @override
  @JsonKey()
  List<File>? get proImageFile {
    final value = _proImageFile;
    if (value == null) return null;
    if (_proImageFile is EqualUnmodifiableListView) return _proImageFile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SellPanelStat(isLogin: $isLogin, isAuthenticaion: $isAuthenticaion, proTitle: $proTitle, proDesciption: $proDesciption, proPrice: $proPrice, proImageFile: $proImageFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SellPanelStatImpl &&
            (identical(other.isLogin, isLogin) || other.isLogin == isLogin) &&
            (identical(other.isAuthenticaion, isAuthenticaion) ||
                other.isAuthenticaion == isAuthenticaion) &&
            (identical(other.proTitle, proTitle) ||
                other.proTitle == proTitle) &&
            (identical(other.proDesciption, proDesciption) ||
                other.proDesciption == proDesciption) &&
            (identical(other.proPrice, proPrice) ||
                other.proPrice == proPrice) &&
            const DeepCollectionEquality()
                .equals(other._proImageFile, _proImageFile));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLogin,
      isAuthenticaion,
      proTitle,
      proDesciption,
      proPrice,
      const DeepCollectionEquality().hash(_proImageFile));

  /// Create a copy of SellPanelStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SellPanelStatImplCopyWith<_$SellPanelStatImpl> get copyWith =>
      __$$SellPanelStatImplCopyWithImpl<_$SellPanelStatImpl>(this, _$identity);
}

abstract class _SellPanelStat implements SellPanelStat {
  factory _SellPanelStat(
      {final bool isLogin,
      final bool isAuthenticaion,
      final String? proTitle,
      final String? proDesciption,
      final double proPrice,
      final List<File>? proImageFile}) = _$SellPanelStatImpl;

  @override
  bool get isLogin;
  @override
  bool get isAuthenticaion;
  @override
  String? get proTitle;
  @override
  String? get proDesciption;
  @override
  double get proPrice;
  @override
  List<File>? get proImageFile;

  /// Create a copy of SellPanelStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SellPanelStatImplCopyWith<_$SellPanelStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
