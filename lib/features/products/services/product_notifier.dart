// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/products/models/product_models.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
part 'product_notifier.g.dart';
part 'product_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(Products user) = _Success;
  const factory AuthState.error(String message) = _Error;
}

@riverpod
class ProductUploadNotifier extends _$ProductUploadNotifier {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  AuthState build() => const AuthState.initial();

  Future<void> productUploaderToFirebase(
    Products products,
  ) async {
    try {
      const AuthState.loading();
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User not logged in';
      }

      final String uniqueId = const Uuid().v4();
      final List<String> imageUrls = [];

      // Upload multiple images
      for (var i = 0; i < products.imageUrls!.length; i++) {
        final storageRef = _storage
            .ref()
            .child('product')
            .child('${user.uid}_${uniqueId}_$i.jpg');

        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploaded-by': user.uid,
            'image-index': i.toString(),
          },
        );

        try {
          await storageRef.putFile(products.imageUrls![i], metadata);
          final url = await storageRef.getDownloadURL();
          imageUrls.add(url);
          // Update state with success

          print('Product image $i successfully uploaded');
        } catch (e) {
          // If an image upload fails, delete previously uploaded images
          for (final uploadedUrl in imageUrls) {
            try {
              await _storage.refFromURL(uploadedUrl).delete();
            } catch (deleteError) {
              print('Failed to delete image: $deleteError');
            }
          }
          throw 'Failed to upload image $i: $e';
        }
      }

      try {
        await _firestore.collection('ProductData').add({
          'uid': products.id,
          'producttitle': products.title,
          'productprice': products.price,
          'productimageUrls': imageUrls, // Store all image URLs
          'mainImageUrl': imageUrls.isNotEmpty
              ? imageUrls[0]
              : null, // Store first image as main
          'productdescription': products.description,
          'createdAt': FieldValue.serverTimestamp(),
          'averageRating': products.averageRating,
          'reviewCount': products.reviewCount,
        });

        print('Product successfully uploaded with ${imageUrls.length} images');
      } catch (e) {
        // If saving to Firestore fails, delete all uploaded images
        for (final url in imageUrls) {
          try {
            await _storage.refFromURL(url).delete();
          } catch (deleteError) {
            print('Failed to delete image: $deleteError');
          }
        }
        throw 'Failed to save product data: $e';
      }
    } catch (e) {
      throw 'Something went wrong nabi: $e';
    }
  }

  // Favorite
  Future<void> uploadFavoriteItems(
    Products products,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User not logged in';
      }

      if (products.imageUrl == null || products.imageUrl!.isEmpty) {
        throw 'No image URL available';
      }

      // Create a unique document ID combining user and product
      final String docId = '${user.uid}_${products.title.replaceAll(' ', '_')}';
      final docRef = _firestore.collection('FavoriteItems').doc(docId);

      final doc = await docRef.get();

      if (doc.exists) {
        // If exists, delete it (toggle off)
        await docRef.delete();
        print('Removed from favorites');
      } else {
        // If doesn't exist, add it (toggle on)
        await docRef.set({
          'uid': user.uid,
          'producttitle': products.title,
          'productprice': products.price,
          'productimageUrl': products.imageUrl,
          'productdescription': products.description,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Added to favorites');
      }
    } catch (e) {
      throw 'Failed to toggle favorite: $e';
    }
  }

  //ADD To Cart
  Future<void> uploadToCart(
    Products products,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User not logged in';
      }

      if (products.imageUrl == null || products.imageUrl!.isEmpty) {
        throw 'No image URL available';
      }

      // Create a unique document ID combining user and product
      final String docId = '${user.uid}_${products.title.replaceAll(' ', '_')}';
      final docRef = _firestore.collection('CartItems').doc(docId);

      final doc = await docRef.get();

      if (doc.exists) {
        // If exists, delete it (toggle off)
        await docRef.delete();
        print('Removed from favorites');
      } else {
        // If doesn't exist, add it (toggle on)
        await docRef.set({
          'uid': user.uid,
          'producttitle': products.title,
          'productprice': products.price,
          'productimageUrl': products.imageUrl,
          'productdescription': products.description,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Added to favorites');
      }
    } catch (e) {
      throw 'Failed to toggle favorite: $e';
    }
  }

  // Review
  // Future<void> addReviewData(Review reveiw) async {
  //   final storageRef = _storage
  //       .ref()
  //       .child('UserImages')
  //       .child('${userCredential.user!.uid}.jpg');

  //   final metadata = SettableMetadata(
  //     contentType: 'image/jpeg',
  //     customMetadata: {'uploaded-by': userCredential.user!.uid},
  //   );

  //   await storageRef.putFile(userModel.imageFile!, metadata);

  //   // Get image URL
  //   final imageUrl = await storageRef.getDownloadURL();

  //   // Create updated user model with image URL
  //   final updatedUser = userModel.copyWith(
  //     userid: userCredential.user!.uid,
  //     imageUrl: imageUrl,
  //     createdAt: DateTime.now(),
  //   );
  // }
}
