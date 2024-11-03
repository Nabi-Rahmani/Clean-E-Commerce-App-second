// ignore_for_file: avoid_print

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

  // Modified to support offline
  Stream<QuerySnapshot> getProductReviews(String productUid) {
    return _firestore
        .collection('ProductData')
        .doc(productUid)
        .collection('Reviews')
        .orderBy('createdAt', descending: true)
        .snapshots(includeMetadataChanges: true) // Add this for offline support
        .map((snapshot) {
      // Log data source
      final source = snapshot.metadata.isFromCache ? 'local cache' : 'server';
      print('Review data came from: $source');
      return snapshot;
    });
  }

  Future<void> addReview(
    String productUid,
    String comment,
    File? image,
    double rating,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not logged in';

      // 1. Start a batch write
      final batch = _firestore.batch();

      // 2. Get product reference
      final productRef = _firestore.collection('ProductData').doc(productUid);

      // 3. Create new review reference
      final reviewRef = productRef.collection('Reviews').doc();

      // 4. Handle image upload
      String? imageUrl;
      String? pendingImagePath;

      if (image != null) {
        try {
          final ref = _storage
              .ref()
              .child('product_reviews')
              .child(productUid)
              .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

          await ref.putFile(image);
          imageUrl = await ref.getDownloadURL();
        } catch (e) {
          pendingImagePath = image.path;
          print('Image upload deferred: $e');
        }
      }

      // 5. Prepare review data
      final reviewData = {
        'userId': user.uid,
        'userName': user.displayName ?? 'Anonymous',
        'comment': comment,
        'rating': rating,
        if (imageUrl != null) 'imageUrl': imageUrl, // Only include if not null
        if (pendingImagePath != null) 'pendingImagePath': pendingImagePath,
        'createdAt': FieldValue.serverTimestamp(),
        'isOffline': pendingImagePath != null,
      };

      // 6. Add review to batch
      batch.set(reviewRef, reviewData);

      // 7. Get current product data safely
      final productDoc = await productRef.get();
      final currentRating = productDoc.exists
          ? (productDoc.data()?['averageRating'] ?? 0.0)
          : 0.0;
      final currentCount =
          productDoc.exists ? (productDoc.data()?['reviewCount'] ?? 0) : 0;

      // 8. Calculate new rating
      final newCount = currentCount + 1;
      final totalPoints = (currentRating * currentCount) + rating;
      final newAverage = totalPoints / newCount;

      // 9. Update product rating in batch
      batch.set(
        productRef,
        {
          'averageRating': newAverage,
          'reviewCount': newCount,
        },
        SetOptions(merge: true), // Use merge to avoid overwriting other fields
      );

      // 10. Commit both operations
      await batch.commit();

      // 11. Handle pending image upload if needed
      if (pendingImagePath != null) {
        _scheduleImageUpload(productUid, reviewRef.id, image!);
      }
    } catch (e) {
      print('Error adding review: $e'); // Add this for debugging
      throw 'Failed to add review: $e';
    }
  }

  // New method to handle deferred image uploads
  void _scheduleImageUpload(String productUid, String reviewId, File image) {
    _firestore
        .collection('ProductData')
        .doc(productUid)
        .collection('Reviews')
        .doc(reviewId)
        .snapshots()
        .listen((snapshot) async {
      if (!snapshot.metadata.isFromCache &&
          snapshot.data()?['pendingImagePath'] != null) {
        try {
          // We're online and have a pending image
          final ref = _storage
              .ref()
              .child('product_reviews')
              .child(productUid)
              .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

          await ref.putFile(image);
          final imageUrl = await ref.getDownloadURL();

          // Update the review with the uploaded image URL
          await snapshot.reference.update({
            'imageUrl': imageUrl,
            'pendingImagePath': null,
            'isOffline': false,
          });
        } catch (e) {
          print('Deferred image upload failed: $e');
        }
      }
    });
  }

  // Modified to include offline metadata
  Stream<Map<String, dynamic>> getProductRating(String productUid) {
    return _firestore
        .collection('ProductData')
        .doc(productUid)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      final source = snapshot.metadata.isFromCache ? 'local cache' : 'server';
      print('Rating data came from: $source');

      return {
        'averageRating': snapshot.data()?['averageRating'] ?? 0.0,
        'reviewCount': snapshot.data()?['reviewCount'] ?? 0,
        'isOffline': snapshot.metadata.isFromCache,
      };
    });
  }
}
