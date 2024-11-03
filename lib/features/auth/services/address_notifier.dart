// ignore_for_file: avoid_print

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'address_notifier.freezed.dart';
part 'address_notifier.g.dart';

@freezed
class AddressStates with _$AddressStates {
  factory AddressStates({
    @Default(false) bool isLogins,
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

  void toggleisLogin(bool isLogins) {
    state = state.copyWith(isLogins: !state.isLogins);
    print('Toggled isLogins: ${state.isLogins}');
  }

  void setCity(String city) {
    print('Setting city: $city');
    state = state.copyWith(city: city);
    print('Updated state: $state');
  }

  void setDistrict(String district) {
    print('Setting district: $district');
    state = state.copyWith(district: district);
    print('Updated state: $state');
  }

  void setNeighborhood(String neighborhood) {
    print('Setting neighborhood: $neighborhood');
    state = state.copyWith(neighborhood: neighborhood);
    print('Updated state: $state');
  }

  void setAddress(String address) {
    print('Setting address: $address');
    state = state.copyWith(address: address);
    print('Updated state: $state');
  }

  void setTitle(String title) {
    print('Setting title: $title');
    state = state.copyWith(title: title);
    print('Updated state: $state');
  }
}
