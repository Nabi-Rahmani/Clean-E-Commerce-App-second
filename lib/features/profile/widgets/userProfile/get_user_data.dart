import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/profile/services/usedetails_notifier.dart';
import 'package:e_clean_fcm/features/profile/widgets/userProfile/design_user_pic.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetUserDetails extends ConsumerWidget {
  const GetUserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsStream = ref.watch(productsStreamProvider);
    return productsStream.when(
      data: (snapshot) {
        if (snapshot.docs.isEmpty) {
          return const Center(child: Text('No Data Found'));
        }
        return ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.docs[index];
            final data = doc.data() as Map<String, dynamic>;

            final username = data['userName'] ?? 'Unknown';
            final imageUrl = data['imageUrl'] ?? '';
            final lastName = data['lastName'] ?? '';
            final timeStamp = data['createdAt'] as Timestamp?;
            final dateTime = timeStamp?.toDate() ?? DateTime.now();
            return UserProfileImages(
              dateTime: dateTime,
              userImage: imageUrl,
              userName: username,
              lastName: lastName,
              isMe: true,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
