// First, create a provider to manage favorite state
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteIconStateCheckProvider =
    StateNotifierProvider.family<FavoriteNotifier, bool, String>(
        (ref, productTitle) {
  return FavoriteNotifier(productTitle);
});

class FavoriteNotifier extends StateNotifier<bool> {
  final String productTitle;

  FavoriteNotifier(this.productTitle) : super(false) {
    _initFavoriteState();
  }

  Future<void> _initFavoriteState() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('FavoriteItems')
          .where('uid', isEqualTo: user.uid)
          .where('producttitle', isEqualTo: productTitle)
          .get();

      state = querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking favorite status: $e');
    }
  }

  void toggleFavorite() {
    state = !state;
  }
}
