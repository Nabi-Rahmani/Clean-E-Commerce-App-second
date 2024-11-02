// Part 4: product_reviews_screen.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/Review/services/image_picker_notifier.dart';
import 'package:e_clean_fcm/features/Review/services/reveiw_sevice_notifier.dart';
import 'package:e_clean_fcm/features/Review/widgets/reviw_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'review_screen.g.dart';

@riverpod
class ReviewScreenState extends _$ReviewScreenState {
  @override
  bool build() => false; // isLoading state

  Future<void> submitReview(
      String productUid, String comment, File? image) async {
    if (comment.trim().isEmpty) {
      throw 'Please write a review';
    }

    state = true; // Start loading
    try {
      await ref.read(reviewServicesProvider.notifier).addReview(
            productUid,
            comment,
            image,
          );
    } finally {
      state = false; // End loading
    }
  }
}

class ProductReviewsScreen extends ConsumerStatefulWidget {
  final String productUid;

  const ProductReviewsScreen({
    super.key,
    required this.productUid,
  });

  @override
  ConsumerState<ProductReviewsScreen> createState() =>
      _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends ConsumerState<ProductReviewsScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = ref.watch(imagePickerReviewNotifierProvider);
    final isLoading = ref.watch(reviewScreenStateProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ref
                  .watch(reviewServicesProvider.notifier)
                  .getProductReviews(widget.productUid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final reviews = snapshot.data?.docs ?? [];
                return ListView.builder(
                  reverse: true,
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review =
                        reviews[index].data() as Map<String, dynamic>;
                    return ReviewCard(review: review);
                  },
                );
              },
            ),
          ),
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
                        child: TextField(
                          controller: _commentController,
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
                      IconButton(
                        icon: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.send),
                        onPressed: isLoading
                            ? null
                            : () async {
                                try {
                                  await ref
                                      .read(reviewScreenStateProvider.notifier)
                                      .submitReview(
                                        widget.productUid,
                                        _commentController.text,
                                        selectedImage,
                                      );
                                  _commentController.clear();
                                  ref
                                      .read(imagePickerReviewNotifierProvider
                                          .notifier)
                                      .clearImage();
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
