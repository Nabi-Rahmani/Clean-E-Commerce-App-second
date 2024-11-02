import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/favorites/services/check_favorites_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataDesign extends ConsumerWidget {
  const UserDataDesign({
    super.key,
    required this.userImage,
    required this.productTitle,
    required this.price,
    this.description,
    required this.onTap,
  });

  final String userImage;
  final String productTitle;
  final double price;
  final String? description;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteIconStateCheckProvider(productTitle));
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;

    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color.fromARGB(255, 31, 31, 31)
              : const Color.fromARGB(255, 248, 250, 252),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // Slightly darker shadow
              offset: const Offset(0, 6), // Raised shadow effect
              blurRadius: 12, // Softer blur for a more realistic elevation
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150, // Reduced image height for a compact look
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 246, 246),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(userImage),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 169, 51, 43),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
