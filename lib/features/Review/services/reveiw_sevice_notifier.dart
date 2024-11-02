import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reveiw_sevice_notifier.g.dart';

@riverpod
class ReviewServices extends _$ReviewServices {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Future<void> build() async {}

  Stream<QuerySnapshot> getProductReviews(String productUid) {
    return _firestore
        .collection('ProductData')
        .doc(productUid)
        .collection('Reviews')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addReview(String productUid, String comment, File? image) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not logged in';

      String? imageUrl;
      if (image != null) {
        final ref = _storage
            .ref()
            .child('product_reviews')
            .child(productUid)
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        await ref.putFile(image);
        imageUrl = await ref.getDownloadURL();
      }

      await _firestore
          .collection('ProductData')
          .doc(productUid)
          .collection('Reviews')
          .add({
        'userId': user.uid,
        'userName': user.displayName ?? 'Anonymous',
        'comment': comment,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Failed to add review: $e';
    }
  }
}
