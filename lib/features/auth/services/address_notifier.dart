// ignore_for_file: avoid_print

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'address_notifier.freezed.dart';
part 'address_notifier.g.dart';

@freezed
class AddressStates with _$AddressStates {
  factory AddressStates({
    String? city,
    String? district,
    String? neighborhood,
    String? address,
    String? title,
  }) = _AddressStates;
}

@riverpod
class AddressNotifier extends _$AddressNotifier {
  @override
  AddressStates build() => AddressStates();

  void setCity(String city) {
    print('Setting city: $city');
    state = state.copyWith(city: city);
  }

  void setDistrict(String district) {
    print('Setting distric: $district');
    state = state.copyWith(district: district);
  }

  void setNeighborhood(String neighborhood) {
    print('Setting neighborhood: $neighborhood');
    state = state.copyWith(neighborhood: neighborhood);
  }

  void setAddress(String address) {
    print('Setting address: $address');
    state = state.copyWith(address: address);
  }

  void setTitle(String title) {
    print('Setting title: $title');
    state = state.copyWith(title: title);
  }
}
