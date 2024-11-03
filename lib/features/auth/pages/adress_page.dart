// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:e_clean_fcm/features/auth/models/address_models.dart';
import 'package:e_clean_fcm/features/auth/services/address_firebase_notifer.dart';
import 'package:e_clean_fcm/features/auth/services/address_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressForm extends ConsumerWidget {
  AddressForm({super.key, required this.onNext});
  final VoidCallback onNext;
  final _formKey = GlobalKey<FormState>();
  Future<void> submitAddress(BuildContext context, WidgetRef ref) async {
    // 1. First validate the form
    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      return;
    }

    // 2. Save the form data
    _formKey.currentState!.save();

    try {
      // 3. Get the address data from your form state
      final addressState = ref.read(addressNotifierProvider);

      if (addressState.city == null ||
          addressState.district == null ||
          addressState.neighborhood == null ||
          addressState.address == null ||
          addressState.title == null) {
        print('Required fields are missing');
        return;
      }

      // 4. Create address model
      final address = AddressModeles(
        city: addressState.city!,
        district: addressState.district!,
        neighborhood: addressState.neighborhood!,
        addresses: addressState.address!,
        adressTitle: addressState.title!,
      );

      // 5. Upload to Firebase
      await ref
          .read(addressAuthNotifierProvider.notifier)
          .uploadUserAddress(address);

      // 6. If successful, move to next page
      onNext();
    } catch (e) {
      print('Error submitting address: $e');
      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving address: $e')),
      );
    }
  }

  // final _cityController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressNotifeir = ref.watch(addressNotifierProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Address Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // City
            _buildTextField(
              label: 'City',
              hint: 'Enter city',
              onSaved: (city) => addressNotifeir.setCity(city!),
            ),
            const SizedBox(height: 16),

            // District
            _buildTextField(
                label: 'District',
                hint: 'Enter district',
                onSaved: (district) => addressNotifeir.setDistrict(district!)),
            const SizedBox(height: 16),

            // Neighborhood
            _buildTextField(
                label: 'Neighborhood',
                hint: 'Enter neighborhood',
                onSaved: (neighborhood) =>
                    addressNotifeir.setNeighborhood(neighborhood!)),
            const SizedBox(height: 16),

            // Full Address
            _buildTextField(
              label: 'Address',
              hint: 'Enter full address',
              onSaved: (address) => addressNotifeir.setAddress(address!),
              maxLines: 3,
            ),
            const SizedBox(height: 8),

            // Helper text
            const Text(
              'Please fill in all address details for secure delivery.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),

            // Address Title
            _buildTextField(
              label: 'Address Title',
              hint: 'E.g., Home, Work',
              onSaved: (title) => addressNotifeir.setTitle(title!),
            ),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await submitAddress(context, ref);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required void Function(String?)? onSaved,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          onSaved: onSaved,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${label.toLowerCase()}';
            }
            return null;
          },
        ),
      ],
    );
  }
}
