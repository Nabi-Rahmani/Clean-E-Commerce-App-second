// ignore_for_file: deprecated_member_use_from_same_package

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final user = FirebaseAuth.instance.currentUser;
// Just keep the search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Single provider to fetch products once
final productsProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('ProductData').snapshots();
});
