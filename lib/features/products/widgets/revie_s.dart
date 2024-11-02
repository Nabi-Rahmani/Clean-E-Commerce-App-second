// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// class ReviewService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   // Add review to specific product
//   Future<void> addReview(String productUid, String comment, File? image) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         throw 'User not logged in';
//       }

//       String? imageUrl;
//       if (image != null) {
//         // Create unique name for image
//         final imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

//         // Reference to specific product's images
//         final imageRef =
//             _storage.ref().child('products/$productUid/reviews/$imageName');

//         // Upload image
//         await imageRef.putFile(image);
//         imageUrl = await imageRef.getDownloadURL();
//       }

//       // Add review to specific product's review collection
//       await _firestore
//           .collection('ProductData')
//           .doc(productUid) // Specific product using its UID
//           .collection('Reviews')
//           .add({
//         'userId': user.uid,
//         'userName': user.displayName ?? 'Anonymous',
//         'comment': comment,
//         'imageUrl': imageUrl,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       throw 'Failed to add review: $e';
//     }
//   }

//   // Get reviews for specific product
//   Stream<QuerySnapshot> getProductReviews(String productUid) {
//     return _firestore
//         .collection('ProductData')
//         .doc(productUid) // Specific product using its UID
//         .collection('Reviews')
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }
// }



// class ProductReviews extends StatefulWidget {
//   final String productUid;

//   const ProductReviews({
//     super.key,
//     required this.productUid,
//   });

//   @override
//   State<ProductReviews> createState() => _ProductReviewsState();
// }

// class _ProductReviewsState extends State<ProductReviews> {
//   final _commentController = TextEditingController();
//   final reviewService = ReviewService();
//   File? _selectedImage;
//   bool _isLoading = false;

//   Future<void> _pickImage() async {
//     try {
//       final picker = ImagePicker();
//       final pickedImage = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1024, // Limit image width
//         maxHeight: 1024, // Limit image height
//         imageQuality: 70, // Basic compression
//       );

//       if (pickedImage != null) {
//         setState(() {
//           _selectedImage = File(pickedImage.path);
//         });
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }

//   Future<void> _submitReview() async {
//     if (_commentController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please write a review')),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       await reviewService.addReview(
//         widget.productUid,
//         _commentController.text,
//         _selectedImage, // Pass selected image directly
//       );

//       _commentController.clear();
//       setState(() {
//         _selectedImage = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting review: $e')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Your existing build method remains the same
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           // Reviews list
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: reviewService.getProductReviews(widget.productUid),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final reviews = snapshot.data?.docs ?? [];

//                 // Inside your ListView.builder in the build method, modify the review display part:
//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: reviews.length,
//                   itemBuilder: (context, index) {
//                     final review =
//                         reviews[index].data() as Map<String, dynamic>;
//                     return Card(
//                       margin: const EdgeInsets.all(8),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   review['userName'] ?? 'Anonymous',
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 if (review['createdAt'] !=
//                                     null) // Check if createdAt exists
//                                   Text(
//                                     DateFormat.yMMMd().format(
//                                       (review['createdAt'] as Timestamp)
//                                           .toDate(),
//                                     ),
//                                     style: const TextStyle(color: Colors.grey),
//                                   ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Text(review['comment'] ?? ''),
//                             if (review['imageUrl'] != null &&
//                                 review['imageUrl'].toString().isNotEmpty) ...[
//                               const SizedBox(height: 8),
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   review['imageUrl'],
//                                   height: 200,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       height: 200,
//                                       width: double.infinity,
//                                       color: Colors.grey[200],
//                                       child: const Center(
//                                         child: Icon(Icons.error_outline),
//                                       ),
//                                     );
//                                   },
//                                   loadingBuilder:
//                                       (context, child, loadingProgress) {
//                                     if (loadingProgress == null) return child;
//                                     return Container(
//                                       height: 200,
//                                       width: double.infinity,
//                                       color: Colors.grey[200],
//                                       child: const Center(
//                                         child: CircularProgressIndicator(),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),

//           // Bottom input section
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 4,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 if (_selectedImage != null)
//                   Container(
//                     height: 100,
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(8),
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.file(
//                             _selectedImage!,
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           child: IconButton(
//                             icon: const Icon(Icons.close, color: Colors.white),
//                             style: IconButton.styleFrom(
//                               backgroundColor: Colors.black54,
//                             ),
//                             onPressed: () =>
//                                 setState(() => _selectedImage = null),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.image),
//                         onPressed: _isLoading ? null : _pickImage,
//                       ),
//                       Expanded(
//                         child: TextField(
//                           controller: _commentController,
//                           decoration: const InputDecoration(
//                             hintText: 'Write a review...',
//                             border: InputBorder.none,
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 16),
//                           ),
//                           enabled: !_isLoading,
//                           maxLines: null,
//                         ),
//                       ),
//                       IconButton(
//                         icon: _isLoading
//                             ? const SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child:
//                                     CircularProgressIndicator(strokeWidth: 2),
//                               )
//                             : const Icon(Icons.send),
//                         onPressed: _isLoading ? null : _submitReview,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).padding.bottom),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
