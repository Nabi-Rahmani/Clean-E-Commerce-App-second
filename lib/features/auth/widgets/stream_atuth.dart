import 'package:e_clean_fcm/features/auth/home/login_page.dart';
import 'package:e_clean_fcm/features/presentation/widgets/bottom_navigation.dart';
import 'package:e_clean_fcm/features/presentation/widgets/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamAuth extends ConsumerWidget {
  const StreamAuth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return BottomNavigations();
          } else {
            return SignUpOrLogin();
          }
        });
  }
}
