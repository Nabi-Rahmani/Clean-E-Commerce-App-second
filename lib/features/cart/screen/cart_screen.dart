import 'package:e_clean_fcm/core/constants/app_const_colors.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/features/cart/widgets/get_cart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 18, 18, 18)
            : AppColors.primary,
      ),
      body: MyCartItems(),
    );
  }
}
