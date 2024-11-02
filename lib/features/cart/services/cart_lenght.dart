// ignore_for_file: deprecated_member_use_from_same_package

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/auth/services/auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cart_lenght.g.dart';

@riverpod
Stream<int> currentUserProductsCount(CurrentUserProductsCountRef ref) {
  // Get current user
  final user = ref.watch(authStateChangesProvider).value;

  if (user == null) return Stream.value(0); // Return 0 if no user

  // Get count for current user
  return FirebaseFirestore.instance
      .collection('CartItems')
      .where('uid', isEqualTo: user.uid)
      .snapshots()
      .map((snapshot) => snapshot.size);
}
