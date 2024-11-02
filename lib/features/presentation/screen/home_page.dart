import 'package:e_clean_fcm/core/constants/app_const_colors.dart';
import 'package:e_clean_fcm/core/constants/custom_app_size.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';

import 'package:e_clean_fcm/features/products/services/query_doc.dart';
import 'package:e_clean_fcm/features/products/services/upload_product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../favorites/services/check_favorites_items.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(productsProvider);
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 18, 18, 18)
                      : AppColors.primary),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: AppSizing.isMobile(context) ? 180 : 150,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
              color: isDarkMode
                  ? const Color.fromARGB(255, 18, 18, 18)
                  : AppColors.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: AppSizing.isMobile(context)
                      ? MediaQuery.sizeOf(context).width * 0.9
                      : MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Search Your Products',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.grey),
                    ),
                    onChanged: (value) {
                      ref.read(searchQueryProvider.notifier).state =
                          value.trim();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        RefreshIndicator(
          onRefresh: () async {
            // ref.read(itemsProvider.notifier).refreshItems();
          },
          child: Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: AppSizing.isMobile(context) ? 180 : 150,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Reset the search query to show all products
                            ref.read(searchQueryProvider.notifier).state = "";
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.greyShade200(true),
                              radius: 30,
                              child: const Text(
                                'All',
                              ), // Label for clarity
                            ),
                          ),
                        ),

                        // Add more CircleAvatar buttons for different categories as needed
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: searchResults.when(
                      data: (snapshot) {
                        if (snapshot.docs.isEmpty) {
                          return const Center(child: Text('No products found'));
                        }
                        return ProductReceiveData(querySnapshot: snapshot);
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
