import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/favorites/services/check_favorites_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.userImage,
    required this.productTitle,
    required this.price,
    required this.onPressed,
  });

  final String userImage;
  final String productTitle;
  final double price;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteIconStateCheckProvider(productTitle));
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: NetworkImage(userImage),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          // Product Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Action Buttons
                Row(
                  children: [
                    // Size Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Text('XL'),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Color Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Text('Blue'),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Save Button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                    // Delete Button
                    IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
