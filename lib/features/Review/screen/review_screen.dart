// Part 4: product_reviews_screen.dart
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/Review/services/image_picker_notifier.dart';
import 'package:e_clean_fcm/features/Review/services/rating_state.dart';
import 'package:e_clean_fcm/features/Review/services/reveiw_sevice_notifier.dart';
import 'package:e_clean_fcm/features/Review/services/textfeild_state.dart';
import 'package:e_clean_fcm/features/Review/widgets/rating_statics.dart';
import 'package:e_clean_fcm/features/Review/widgets/reviw_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'review_screen.g.dart';

@riverpod
class ReviewScreenState extends _$ReviewScreenState {
  @override
  bool build() => false;

  Future<void> submitReview(
    String productUid,
    String comment,
    File? image,
    double rating,
  ) async {
    if (comment.trim().isEmpty) {
      throw 'Please write a review';
    }

    state = true;
    try {
      // Use .notifier to access methods
      await ref.read(reviewServicesProvider.notifier).addReview(
            productUid,
            comment,
            image,
            rating,
          );
    } finally {
      state = false;
    }
  }
}

final _fireStore = FirebaseFirestore.instance;

class ProductReviewsScreen extends ConsumerWidget {
  final String productUid;

  const ProductReviewsScreen({
    super.key,
    required this.productUid,
  });

// Update delete function to work offline
  void _deleteMessage(BuildContext context, String documentId) async {
    try {
      // Delete will be queued if offline
      await _fireStore.collection('Reviews').doc(documentId).delete();

      if (context.mounted) {
        if (Platform.isIOS) {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Message Deleted'),
              content: const Text('The message has been deleted successfully.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Message Deleted'),
              content: const Text('The message has been deleted successfully.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      print('Error deleting message: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting message: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textControllers = ref.watch(textFieldNotifierProvider);
    final textController = ref.watch(textFieldNotifierProvider.notifier);
    final selectedImage = ref.watch(imagePickerReviewNotifierProvider);
    final isLoading = ref.watch(reviewScreenStateProvider);
    final currentRating = ref.watch(ratingStateProvider);
    return Scaffold(
      body: Column(
        children: [
          // Offline indicator
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('ProductData')
                .limit(1)
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              // Ensure snapshot has data before accessing metadata
              final isOffline = snapshot.data?.metadata.isFromCache ?? false;

              if (isOffline) {
                return Container(
                  color: Colors.orange,
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_off, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Offline Mode - Changes will sync when online',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // Reviews list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ref
                  .watch(reviewServicesProvider.notifier)
                  .getProductReviews(productUid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final reviews = snapshot.data?.docs ?? [];

                // Ensure snapshot has data before accessing metadata
                final isFromCache =
                    snapshot.data?.metadata.isFromCache ?? false;
                return ListView.builder(
                  reverse: true,
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review =
                        reviews[index].data() as Map<String, dynamic>;
                    return Stack(
                      children: [
                        ReviewCard(
                          review: review,
                          onPressed: () =>
                              _deleteMessage(context, reviews[index].id),
                        ),
                        if (isFromCache || review['isOffline'] == true)
                          const Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(
                              Icons.cloud_off,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
//
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Rate: '),
                ...List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      ref.read(ratingStateProvider.notifier).state =
                          (index + 1).toDouble();
                    },
                    icon: Icon(
                      index < currentRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                  );
                }),
              ],
            ),
          ),
          // Input section
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Image preview
                if (selectedImage != null)
                  Container(
                    height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            selectedImage,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black54,
                            ),
                            onPressed: () => ref
                                .read(
                                    imagePickerReviewNotifierProvider.notifier)
                                .clearImage(),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Input row
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: isLoading
                            ? null
                            : () => ref
                                .read(
                                    imagePickerReviewNotifierProvider.notifier)
                                .pickImage(),
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) =>
                              textController.setTextControler(text),
                          decoration: const InputDecoration(
                            hintText: 'Write a review...',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                          enabled: !isLoading,
                          maxLines: null,
                        ),
                      ),
                      // Submit button
                      IconButton(
                        icon: isLoading
                            ? const CircularProgressIndicator()
                            : const Icon(Icons.send),
                        onPressed: isLoading
                            ? null
                            : () async {
                                // Check if rating is selected
                                final rating = ref.read(ratingStateProvider);
                                if (rating == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please select a rating'),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  // Submit review with rating
                                  await ref
                                      .read(reviewScreenStateProvider.notifier)
                                      .submitReview(
                                        productUid,
                                        textControllers.textFielController!,
                                        selectedImage,
                                        rating,
                                      );

                                  // Clear all inputs
                                  textController.setTextControler('');
                                  ref
                                      .read(imagePickerReviewNotifierProvider
                                          .notifier)
                                      .clearImage();
                                  ref.read(ratingStateProvider.notifier).state =
                                      0;
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
