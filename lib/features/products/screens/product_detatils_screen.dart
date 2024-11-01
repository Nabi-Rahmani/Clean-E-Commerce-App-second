// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ProductDetailScreen extends ConsumerWidget {
//   const ProductDetailScreen({
//     super.key,
//     required this.title,
//     required this.productImages,
//     this.description,
//   });

//   final String title;
//   final String productImages;
//   final String? description;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Debug: Print received data
//     print('Product Detail Screen - Title: $title');
//     print('Product Detail Screen - Images: $productImages');

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(color: Colors.white),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (productImages.isNotEmpty) ...[
//               Stack(
//                 children: [
//                   SizedBox(
//                     height: 300,
//                     child: PageView.builder(
//                       itemCount: productImages.length,
//                       itemBuilder: (context, index) {
//                         print(
//                             'Loading image at index $index: ${productImages[index]}');
//                         return Image.network(
//                           productImages[index],
//                           fit: BoxFit.cover,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             print('Error loading image: $error');
//                             return Image.network(
//                               'https://placehold.co/600x400',
//                               fit: BoxFit.cover,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   // Optional: Add page indicator
//                   Positioned(
//                     bottom: 10,
//                     left: 0,
//                     right: 0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         productImages.length,
//                         (index) => Container(
//                           width: 8,
//                           height: 8,
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Text('$description'),
//               const SizedBox(height: 16),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   title,
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ),
//             ] else
//               const Center(
//                 child: Text('No images available'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.productImage,
    required this.price,
    this.description,
  });

  final String title;
  final String productImage;
  final double price;
  final String? description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String selectedSize = 'S';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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

            // Product Title, Price, and Description
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),

            // Size Options
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Size',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['S', 'M', 'L', 'XL'].map((size) {
                return ChoiceChip(
                  label: Text(size),
                  selected: selectedSize == size,
                  onSelected: (bool selected) {
                    selectedSize = size;
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: selectedSize == size ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            const Spacer(),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
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
          ],
        ),
      ),
    );
  }
}
