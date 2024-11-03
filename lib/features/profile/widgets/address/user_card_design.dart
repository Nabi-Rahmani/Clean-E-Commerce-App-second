// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_clean_fcm/features/auth/services/address_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'address_detail_row.dart'; // Import the extracted widget

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key,
      required this.dateTime,
      required this.addressTitle,
      required this.city,
      required this.district,
      required this.neighborhood,
      required this.address,
      required this.documentId});
  final String address;
  final String addressTitle;
  final String city;
  final String district;
  final String neighborhood;
  final DateTime dateTime;
  final String documentId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  addressTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Show bottom sheet for editing
                    _showEditBottomSheet(
                      context,
                      documentId: documentId,
                      currentAddress: {
                        'address': address,
                        'addresstitle': addressTitle,
                        'city': city,
                        'district': district,
                        'neighborhood': neighborhood,
                      },
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const Gap(16),
            AddressDetailRow(
              icon: Icons.location_on,
              label: 'Address',
              value: address,
            ),
            // Address Details
            AddressDetailRow(
              icon: Icons.location_city,
              label: 'City',
              value: city,
            ),
            const Gap(8),
            AddressDetailRow(
              icon: Icons.map,
              label: 'District',
              value: district,
            ),
            const Gap(8),
            AddressDetailRow(
              icon: Icons.home,
              label: 'Neighborhood',
              value: neighborhood,
            ),
            const Gap(8),
            AddressDetailRow(
              icon: Icons.pin_drop,
              label: 'Address Title Home APT',
              value: addressTitle,
            ),
            const Gap(16),

            // Date
            Text(
              'Added ${DateFormat('yyyy-MM-dd').format(dateTime)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add this method to show bottom sheet
void _showEditBottomSheet(
  BuildContext context, {
  required String documentId,
  required Map<String, String> currentAddress,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              UpdateFormPage(
                documentId: documentId,
                currentAddress: currentAddress,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// 2. Add a simple edit form widget
class UpdateFormPage extends ConsumerWidget {
  final String documentId;
  final Map<String, String> currentAddress;

  const UpdateFormPage({
    super.key,
    required this.documentId,
    required this.currentAddress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final formState = ref.watch(addressNotifierProvider);
    final formNotifier = ref.read(addressNotifierProvider.notifier);
    final isLoading = formState.isLogins;

    Future<void> updateAddress() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      formKey.currentState!.save();

      formNotifier.toggleisLogin(formState.isLogins);

      // Read the latest state
      final updatedFormState = ref.read(addressNotifierProvider);

      try {
        // Update in Firestore
        await FirebaseFirestore.instance
            .collection('AddressDetails')
            .doc(documentId)
            .update({
          'address': updatedFormState.address,
          'addresstitle': updatedFormState.title,
          'city': updatedFormState.city,
          'district': updatedFormState.district,
          'neighborhood': updatedFormState.neighborhood,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating address: $e')),
        );
      } finally {
        formNotifier.toggleisLogin(!formState.isLogins);
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: currentAddress['addresstitle'],
            onSaved: (title) {
              formNotifier.setTitle(title!);
            },
            decoration: const InputDecoration(labelText: 'Address Title'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: currentAddress['city'],
            onSaved: (city) {
              formNotifier.setCity(city!);
            },
            decoration: const InputDecoration(labelText: 'City'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: currentAddress['district'],
            onSaved: (district) {
              formNotifier.setDistrict(district!);
            },
            decoration: const InputDecoration(labelText: 'District'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: currentAddress['neighborhood'],
            onSaved: (neighborhood) {
              formNotifier.setNeighborhood(neighborhood!);
            },
            decoration: const InputDecoration(labelText: 'Neighborhood'),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: currentAddress['address'],
            onSaved: (address) {
              formNotifier.setAddress(address!);
            },
            decoration: const InputDecoration(labelText: 'Full Address'),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: isLoading ? null : updateAddress,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save Changes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
