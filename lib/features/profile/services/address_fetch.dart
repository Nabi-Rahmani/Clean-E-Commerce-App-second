// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/auth/services/auth_notifier.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_fetch.g.dart';

@riverpod
FirebaseFirestore addressFirestores(Ref ref) => FirebaseFirestore.instance;

// Stream provider for user address data
@riverpod
Stream<QuerySnapshot> userAddressData(Ref ref) {
  final user = ref.watch(authStateChangesProvider).value;

  if (user == null) {
    print('No authenticated user found'); // Debug print
    return const Stream.empty();
  }

  return ref
      .watch(addressFirestoresProvider)
      .collection('AddressDetails')
      .where('userId', isEqualTo: user.uid)
      .snapshots()
      .map((snapshot) {
    print('Data fetched: ${snapshot.docs.length} documents'); // Debug print
    if (snapshot.docs.isEmpty) {
      print('No documents found in the collection'); // Debug print
    }
    return snapshot;
  });
}
