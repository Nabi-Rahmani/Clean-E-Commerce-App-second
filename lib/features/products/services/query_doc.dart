import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Just keep the search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Single provider to fetch products once
final productsProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('ProductData').snapshots();
});
