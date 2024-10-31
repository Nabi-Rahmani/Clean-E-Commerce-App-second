// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:intl/intl.dart';

class UserProfileImages extends StatelessWidget {
  const UserProfileImages(
      {super.key,
      required this.dateTime,
      required this.userImage,
      required this.userName,
      required this.lastName,
      required this.isMe});
  final String userImage;
  final String userName;
  final String lastName;
  final DateTime dateTime;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          height: 100,
          width: 100,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImage,
            ),
            radius: 23,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userName,
              style: const TextStyle(color: Colors.white),
            ),
            const Gap(5),
            Text(
              lastName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Text(
          'Joined ${DateFormat('yyyy-MM-dd').format(dateTime)}',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
