// ignore_for_file: avoid_print

import 'dart:io';

import 'package:e_clean_fcm/features/profile/widgets/user_data_desgin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPublishedProducts extends ConsumerWidget {
  MyPublishedProducts({super.key});
  final _fireStore = FirebaseFirestore.instance;
  void _deleteMessage(BuildContext context, String documentId) async {
    try {
      await _fireStore.collection('ProductData').doc(documentId).delete();
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

      print('Error deleting message: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    // Debug: Print user ID
    print('Current User ID: ${user?.uid}');

    if (user == null) {
      return const Center(child: Text('No User Logged In'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('ProductData')
          .where('uid',
              isEqualTo: user.uid) // Check this field name in Firestore
          .snapshots(),
      builder: (context, snapshot) {
        // Debug: Print snapshot state
        print('Connection State: ${snapshot.connectionState}');
        print('Has Error: ${snapshot.hasError}');
        print('Has Data: ${snapshot.hasData}');
        print('Docs Length: ${snapshot.data?.docs.length}');

        if (snapshot.hasError) {
          print('Error: ${snapshot.error}'); // Debug: Print error
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Debug: Print documents data
        if (snapshot.hasData) {
          print('Number of documents: ${snapshot.data!.docs.length}');
          for (var doc in snapshot.data!.docs) {
            print('Document Data: ${doc.data()}');
          }
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Data Found'));
        }

        final productList = <Widget>[];

        for (var doc in snapshot.data!.docs) {
          final data = doc.data() as Map<String, dynamic>;
          // Debug: Print each document's data
          print('Processing document: $data');

          final proTitle = data['producttitle'] ?? 'Unknown';
          final proImageUrl = data['mainImageUrl'] ?? '';
          final proPrice = (data['productprice'] is num)
              ? (data['productprice'] as num).toDouble()
              : double.tryParse(data['productprice'].toString()) ?? 0.0;

          if (proImageUrl.isEmpty || proTitle.isEmpty || proPrice <= 0) {
            print(
                'Invalid product data: title=$proTitle, imageUrl=$proImageUrl, price=$proPrice');
            continue; // Skip this item if it's not valid
          }

          // FocusScope.of(context).unfocus();

          final categoryGridView = UserDataDesign(
            userImage: proImageUrl,
            productTitle: proTitle,
            price: proPrice,
            onTap: () {
              _deleteMessage(context, doc.id);
            },
          );

          productList.add(categoryGridView);
        }

        // Debug: Print final list length
        print('Final product list length: ${productList.length}');

        return ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) => productList[index],
        );
      },
    );
  }
}
