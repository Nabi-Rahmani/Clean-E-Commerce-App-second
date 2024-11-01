import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/products/screens/product_detatils_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryGridView extends ConsumerWidget {
  const CategoryGridView({
    super.key,
    required this.userImage,
    required this.productTitle,
    required this.price,
    this.description,
  });

  final String userImage;

  final String productTitle;
  final double price;
  final String? description;

  // bool isFavorite = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isFavorite = ref.watch(favoriteIconStateCheckProvider(productTitle));
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return ProductDetailScreen(
            title: productTitle,
            price: price,
            productImage: userImage,
          );
        }));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color.fromARGB(255, 31, 31, 31)
              : const Color.fromARGB(255, 248, 250, 252),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Favorite Button
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 246, 246),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(userImage),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    // child: Icon(
                    //   isFavorite
                    //       ? Icons.favorite
                    //       : Icons.favorite_border, // Toggle icon based on state
                    //   color: Colors.red,
                    // ),
                  ),
                ),
              ],
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
