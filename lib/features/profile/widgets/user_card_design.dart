import 'package:e_clean_fcm/features/profile/widgets/get_user_address.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.dateTime,
    required this.addressTitle,
    required this.city,
    required this.district,
    required this.neighborhood,
    required this.address,
  });
  final String address;
  final String addressTitle;
  final String city;
  final String district;
  final String neighborhood;
  final DateTime dateTime;

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

class AddressDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AddressDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey[600],
        ),
        const Gap(8),
        Text(
          '$label:',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// Usage in a screen
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: const AddressListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new address
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
