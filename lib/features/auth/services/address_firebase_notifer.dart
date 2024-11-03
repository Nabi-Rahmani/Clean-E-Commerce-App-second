// ignore_for_file: deprecated_member_use_from_same_package, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/auth/models/address_models.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_firebase_notifer.freezed.dart';
part 'address_firebase_notifer.g.dart';

// Create an auth state class
@freezed
class AddressAuthState with _$AddressAuthState {
  const factory AddressAuthState.initial() = _Initial;
  const factory AddressAuthState.loading() = _Loading;
  const factory AddressAuthState.success(AddressModeles address) = _Success;
  const factory AddressAuthState.error(String message) = _Error;
}

@riverpod
class AddressAuthNotifier extends _$AddressAuthNotifier {
  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  @override
  AddressAuthState build() => const AddressAuthState.initial();

  Future<void> uploadUserAddress(AddressModeles address) async {
    try {
      // Set loading state
      state = const AddressAuthState.loading();

      // 3. Validate address data
      if (address.city.isEmpty ||
          address.district.isEmpty ||
          address.neighborhood.isEmpty ||
          address.addresses.isEmpty ||
          address.adressTitle.isEmpty) {
        state = const AddressAuthState.error('All fields are required');
        return;
      }

      // Save user data to Firestore
      await _firestore
          .collection('AddressDetails')
          .doc(_auth.currentUser!.uid)
          .set({
        'userId': _auth.currentUser!.uid,
        'city': address.city,
        'district': address.district,
        'neighborhood': address.neighborhood,
        'address': address.addresses,
        'addresstitle': address.adressTitle,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Update state with success
      state = AddressAuthState.success(address);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        state = const AddressAuthState.error(
            'The email address is already in use.');
      } else {
        state = AddressAuthState.error('Something went wrong: ${e.message}');
      }
    } catch (e) {
      state = AddressAuthState.error('Failed to sign up: $e');
    }
  }

  Future<void> updateAddress(AddressModeles address) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        state = const AddressAuthState.error('User not authenticated');
        return;
      }

      state = const AddressAuthState.loading();

      await _firestore.collection('AddressDetails').doc(user.uid).update({
        'city': address.city,
        'district': address.district,
        'neighborhood': address.neighborhood,
        'address': address.addresses,
        'addresstitle': address.adressTitle,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      state = AddressAuthState.success(address);
    } catch (e) {
      state = AddressAuthState.error('Failed to update address: $e');
      print('Update error: $e');
    }
  }

  // 9. Add method to get current address
  Future<void> getCurrentAddress() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        state = const AddressAuthState.error('User not authenticated');
        return;
      }

      state = const AddressAuthState.loading();

      final doc =
          await _firestore.collection('AddressDetails').doc(user.uid).get();

      if (doc.exists) {
        final data = doc.data()!;
        final address = AddressModeles(
          city: data['city'] as String,
          district: data['district'] as String,
          neighborhood: data['neighborhood'] as String,
          addresses: data['address'] as String,
          adressTitle: data['addresstitle'] as String,
        );
        state = AddressAuthState.success(address);
      } else {
        state = const AddressAuthState.initial();
      }
    } catch (e) {
      state = AddressAuthState.error('Failed to get address: $e');
      print('Get address error: $e');
    }
  }
}
