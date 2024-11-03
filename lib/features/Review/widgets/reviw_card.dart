// Part 3: review_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

// class ReviewCard extends StatelessWidget {
//   final Map<String, dynamic> review;
//   final void Function()? onPressed;

//   const ReviewCard({
//     super.key,
//     required this.review,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   review['userName'] ?? 'Anonymous',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     ...List.generate(5, (index) {
//                       return Icon(
//                         index < (review['rating'] ?? 0)
//                             ? Icons.star
//                             : Icons.star_border,
//                         size: 16,
//                         color: Colors.amber,
//                       );
//                     }),
//                     const Gap(Sizes.p16),
//                     if (review['createdAt'] != null)
//                       Text(
//                         DateFormat.yMMMd().format(
//                           (review['createdAt'] as Timestamp).toDate(),
//                         ),
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     IconButton(
//                       onPressed: onPressed,
//                       icon: const Icon(Icons.delete_outline),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(review['comment'] ?? ''),
//             // Modified image section
//             if (review['imageUrl'] != null &&
//                 review['imageUrl'].toString().isNotEmpty) ...[
//               const SizedBox(height: 8),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   review['imageUrl'],
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     print('Image error: $error'); // For debugging
//                     return Container(
//                       height: 200,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: const Center(
//                         child: Icon(
//                           Icons.error_outline,
//                           size: 40,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     );
//                   },
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Container(
//                       height: 200,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ] else ...[
//               const SizedBox(height: 8),
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 color: Colors.grey[200],
//                 child: const Center(
//                   child: Icon(
//                     Icons.image_not_supported,
//                     size: 40,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;
  final void Function()? onPressed;

  const ReviewCard({
    super.key,
    required this.review,
    required this.onPressed,
  });

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
                        index < (review['rating'] ?? 0)
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
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(review['comment'] ?? ''),

            // New image handling using StreamBuilder
            StreamBuilder<String?>(
              stream: _getImageUrlStream(),
              initialData: review['imageUrl'] as String?,
              builder: (context, snapshot) {
                final imageUrl = snapshot.data;
                if (imageUrl == null || imageUrl.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Stream<String?> _getImageUrlStream() async* {
    if (review['imageUrl'] != null) {
      await Future.delayed(Duration.zero); // Wait for widget to be mounted
      yield review['imageUrl'] as String;
    }
  }
}
