import 'package:e_clean_fcm/features/profile/widgets/upload_user_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProductsScreen extends ConsumerWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: MyPublishedProducts()),
        ],
      ),
    );
  }
}
// fix it
