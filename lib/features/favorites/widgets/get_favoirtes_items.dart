import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/favorites/services/check_favorites_items.dart';
import 'package:e_clean_fcm/features/favorites/widgets/favorite_page_desigin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyFavoritedItems extends ConsumerWidget {
  MyFavoritedItems({super.key});
  final _fireStore = FirebaseFirestore.instance;

  void _deleteMessage(BuildContext context, String documentId) async {
    try {
      await _fireStore.collection('FavoriteItems').doc(documentId).delete();
      if (Platform.isIOS) {
        showCupertinoDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Message Deleted'),
            content: const Text('The message has been deleted successfully.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Message Deleted'),
            content: const Text('The message has been deleted successfully.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle errors
      // ignore: avoid_print
      print('Error deleting message: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('No User Logged In')); // Handle no user
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('FavoriteItems')
          .where('uid', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Data Found'));
        }

        final productList = <Widget>[];

        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            // Using the data() method to retrieve the map
            final data = doc.data() as Map<String, dynamic>;
            final proTitle = data['producttitle'] ?? 'Unknown';
            final proImageUrl = data['productimageUrl'] ?? '';
            // Convert price to double safely
            final proPrice = (data['productprice'] is num)
                ? (data['productprice'] as num).toDouble()
                : double.tryParse(data['productprice'].toString()) ?? 0.0;
            FocusScope.of(context).unfocus(); // Unfocus if necessary

            final categoryGridView = FavoritePageDesign(
              userImage: proImageUrl,
              productTitle: proTitle,
              price: proPrice,
              onPressed: () {
                ref
                    .read(favoriteIconStateCheckProvider(proTitle).notifier)
                    .toggleFavorite();
                _deleteMessage(context, doc.id);
              },
            );

            productList.add(categoryGridView);
          }
        }

// Now you can use productList in your UI, e.g., in a GridView
        return ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) => productList[index],
        );
      },
    );
  }
}
