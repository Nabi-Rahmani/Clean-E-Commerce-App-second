// ignore_for_file: unused_local_variable

import 'package:e_clean_fcm/core/constants/app_const_colors.dart';
import 'package:e_clean_fcm/core/constants/app_sizes.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/cart/services/cart_lenght.dart';
import 'package:e_clean_fcm/features/favorites/services/check_favorites_items.dart';
import 'package:e_clean_fcm/features/products/models/product_models.dart';
import 'package:e_clean_fcm/features/products/screens/show_rating.dart';
import 'package:e_clean_fcm/features/products/services/product_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../Review/screen/review_screen.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.productImage,
    required this.price,
    required this.description,
    required this.reviewCount,
  });

  final String title;
  final String productImage;
  final double price;
  final String description;
  final int reviewCount;
  Future<void> submitFavoriteItems(BuildContext context, WidgetRef ref) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to add favorites')),
        );
        return;
      }

      final product = Products(
        id: user.uid,
        title: title,
        description: description,
        price: price,
        userId: user.uid,
        imageUrl: productImage,
      );
      final productUploader = ref
          .read(productUploadNotifierProvider.notifier)
          .uploadFavoriteItems(product);
      ref.read(favoriteIconStateCheckProvider(title).notifier).toggleFavorite();
      // Show success message
      final isFavorite = ref.read(favoriteIconStateCheckProvider(title));
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              isFavorite ? 'Added to favorite' : ' Removed from favorites s'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

// ADD to Cart
  Future<void> sumbitToCart(BuildContext context, WidgetRef ref) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to add favorites')),
        );
        return;
      }

      final product = Products(
        id: user.uid,
        title: title,
        description: description,
        price: price,
        userId: user.uid,
        imageUrl: productImage,
      );
      final productUploader = ref
          .read(productUploadNotifierProvider.notifier)
          .uploadToCart(product);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCount = ref.watch(currentUserProductsCountProvider);
    final isFavorite = ref.watch(favoriteIconStateCheckProvider(title));
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 18, 18, 18)
            : AppColors.primary,
        title: Text(title),
        centerTitle: true,
        actions: [
          AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
            child: IconButton(
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border, // Toggle icon based on state
                color: Colors.red,
              ),
              onPressed: () async {
                submitFavoriteItems(context, ref);
              },
            ),
          ),
          IconButton(
            icon: Badge(
              label: productCount.when(
                data: (count) => Text(count.toString()),
                loading: () => const Text('...'),
                error: (_, __) => const Text('!'),
              ),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Single Product Image
            if (productImage.isNotEmpty)
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(productImage),
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else
              const Center(child: Text('No image available')),

            const SizedBox(height: 16),
            Expanded(
              child: ProductRatingSummary(
                productUid: title,
              ),
            ),
            // Product Title, Price, and Description
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${price.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ct) => ProductReviewsScreen(
                                  productUid: title,
                                )));
                  },
                  child: Row(
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              AppColors.heart, // Color of the underline
                          decorationThickness: 2, // Thickness of the underline
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Text size
                        ),
                      ),
                      const Gap(Sizes.p12),
                      Text(
                        reviewCount.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              description,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Size Options

            const Expanded(child: SizedBox()),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  sumbitToCart(context, ref);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor:
                      isDarkMode ? AppColors.heart : AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Gap(Sizes.p20),
          ],
        ),
      ),
    );
  }
}
