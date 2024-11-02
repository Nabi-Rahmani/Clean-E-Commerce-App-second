// Part 3: review_card.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;
  final void Function()? onPressed;
  const ReviewCard({super.key, required this.review, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review['userName'] ?? 'Anonymous',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < (review['rating'] ?? 0).floor()
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      );
                    }),
                    const Gap(Sizes.p16),
                    if (review['createdAt'] != null)
                      Text(
                        DateFormat.yMMMd().format(
                          (review['createdAt'] as Timestamp).toDate(),
                        ),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    IconButton(
                        onPressed: onPressed,
                        icon: const Icon(Icons.delete_outline)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(review['comment'] ?? ''),
            if (review['imageUrl'] != null &&
                review['imageUrl'].toString().isNotEmpty) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  review['imageUrl'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.error_outline)),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
