import 'package:freezed_annotation/freezed_annotation.dart';
part 'address_models.freezed.dart';

@freezed
class AddressModeles with _$AddressModeles {
  factory AddressModeles({
    required String city,
    required String district,
    required String neighborhood,
    required String addresses,
    required String adressTitle,
  }) = _AddressModeles;
}
