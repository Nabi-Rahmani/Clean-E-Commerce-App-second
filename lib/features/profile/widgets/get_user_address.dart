import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/profile/services/address_fetch.dart';

import 'package:e_clean_fcm/features/profile/widgets/user_card_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressListWidget extends ConsumerWidget {
  const AddressListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsStream = ref
        .watch(userAddressDataProvider); // Ensure the correct provider is used
    return productsStream.when(
      data: (snapshot) {
        print('Data fetched: ${snapshot.docs.length} documents'); // Debug print
        if (snapshot.docs.isEmpty) {
          print('No documents found in the collection'); // Debug print
          return const Center(child: Text('No Data Found'));
        }
        return ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.docs[index];
            final data = doc.data() as Map<String, dynamic>;

            print('Document data: $data'); // Debug print
            final address = data['address'] ?? 'Unknown';
            final addresstitle = data['addresstitle'] ?? 'Unknown';
            final city = data['city'] ?? '';
            final district = data['district'] ?? '';
            final neighborhood = data['neighborhood'] ?? '';
            final timeStamp = data['createdAt'] as Timestamp?;
            final dateTime = timeStamp?.toDate() ?? DateTime.now();
            return AddressCard(
              dateTime: dateTime,
              addressTitle: addresstitle,
              city: city,
              district: district,
              neighborhood: neighborhood,
              address: address,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        print('Error fetching data: $error'); // Debug print
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
