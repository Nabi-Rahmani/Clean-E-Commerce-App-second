import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/products/models/product_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
part 'product_notifier.g.dart';

@riverpod
class ProductUploadNotifier extends _$ProductUploadNotifier {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> build() async {}

  Future<void> productUploaderToFirebase(
      Products products, List<File> images) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User not logged in';
      }

      final String uniqueId = const Uuid().v4();
      final List<String> imageUrls = [];

      // Upload multiple images
      for (var i = 0; i < images.length; i++) {
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
          await storageRef.putFile(images[i], metadata);
          final url = await storageRef.getDownloadURL();
          imageUrls.add(url);
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
}
