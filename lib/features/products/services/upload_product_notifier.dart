import 'package:e_clean_fcm/core/constants/custom_app_size.dart';
import 'package:e_clean_fcm/features/products/services/query_doc.dart';
import 'package:e_clean_fcm/features/products/widgets/catergory_gridview.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductReceiveData extends ConsumerWidget {
  final QuerySnapshot<Object?> querySnapshot;

  const ProductReceiveData({super.key, required this.querySnapshot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final docs = querySnapshot.docs;

    if (docs.isEmpty) {
      return const Center(child: Text('No products available'));
    }

    final filteredDocs = searchQuery.isEmpty
        ? docs
        : docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final title = data['producttitle'].toString().toLowerCase();
            return title.contains(searchQuery.toLowerCase());
          }).toList();

    if (filteredDocs.isEmpty) {
      return Center(
        child: Text('No results found for "$searchQuery"'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppSizing.isMobile(context) ? 2 : 3,
        childAspectRatio: AppSizing.isMobile(context) ? 0.76 : 0.99,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemCount: filteredDocs.length,
      itemBuilder: (context, index) {
        final data = filteredDocs[index].data() as Map<String, dynamic>;

        return CategoryGridView(
          userImage: data['mainImageUrl'] ?? '',
          productTitle: data['producttitle'] ?? '',
          description: data['productdescription'] ?? '',
          price: (data['productprice'] is num)
              ? (data['productprice'] as num).toDouble()
              : 0.0,
        );
      },
    );
  }
}
