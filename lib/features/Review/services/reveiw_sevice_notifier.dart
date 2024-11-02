import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reveiw_sevice_notifier.g.dart';

// @riverpod
// class ReviewServices extends _$ReviewServices {
//   final _firestore = FirebaseFirestore.instance;
//   final _storage = FirebaseStorage.instance;

//   @override
//   Future<void> build() async {}

//   Stream<QuerySnapshot> getProductReviews(String productUid) {
//     return _firestore
//         .collection('ProductData')
//         .doc(productUid)
//         .collection('Reviews')
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }

//   Future<void> addReview(String productUid, String comment, File? image) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) throw 'User not logged in';

//       String? imageUrl;
//       if (image != null) {
//         final ref = _storage
//             .ref()
//             .child('product_reviews')
//             .child(productUid)
//             .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

//         await ref.putFile(image);
//         imageUrl = await ref.getDownloadURL();
//       }

//       await _firestore
//           .collection('ProductData')
//           .doc(productUid)
//           .collection('Reviews')
//           .add({
//         'userId': user.uid,
//         'userName': user.displayName ?? 'Anonymous',
//         'comment': comment,
//         'imageUrl': imageUrl,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       throw 'Failed to add review: $e';
//     }
//   }

//   Stream<Map<String, dynamic>> getProductRating(String productUid) {
//     return _firestore
//         .collection('ProductData')
//         .doc(productUid)
//         .snapshots()
//         .map((snapshot) => {
//               'averageRating': snapshot.data()?['averageRating'] ?? 0.0,
//               'reviewCount': snapshot.data()?['reviewCount'] ?? 0,
//             });
//   }
// }

@riverpod
class ReviewServices extends _$ReviewServices {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Future<void> build() async {
    // Initialize with offline settings
    await _firestore.enablePersistence(
      const PersistenceSettings(synchronizeTabs: true),
    );
  }

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

  // Modified to handle offline image uploads
  Future<void> addReview(String productUid, String comment, File? image) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not logged in';

      // Create review document reference
      final reviewRef = _firestore
          .collection('ProductData')
          .doc(productUid)
          .collection('Reviews')
          .doc(); // Generate ID

      String? imageUrl;
      String? pendingImagePath;

      if (image != null) {
        // Check if we're online before attempting upload
        try {
          final ref = _storage
              .ref()
              .child('product_reviews')
              .child(productUid)
              .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

          await ref.putFile(image);
          imageUrl = await ref.getDownloadURL();
        } catch (e) {
          // If upload fails (likely offline), store the local path
          pendingImagePath = image.path;
          print('Image upload deferred: $e');
        }
      }

      // Create review data
      final reviewData = {
        'userId': user.uid,
        'userName': user.displayName ?? 'Anonymous',
        'comment': comment,
        'imageUrl': imageUrl,
        'pendingImagePath': pendingImagePath,
        'createdAt': FieldValue.serverTimestamp(),
        'isOffline':
            pendingImagePath != null, // Mark as offline if image pending
      };

      // Add the review
      await reviewRef.set(reviewData);

      // If we have a pending image, schedule it for upload when back online
      if (pendingImagePath != null) {
        _scheduleImageUpload(productUid, reviewRef.id, image!);
      }
    } catch (e) {
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
