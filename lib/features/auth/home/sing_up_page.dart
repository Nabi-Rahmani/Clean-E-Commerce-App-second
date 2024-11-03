// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:e_clean_fcm/features/auth/pages/adress_page.dart';
import 'package:e_clean_fcm/features/auth/pages/signup_page.dart';

import 'package:e_clean_fcm/features/auth/services/pageview_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpProgress extends ConsumerWidget {
  SignUpProgress({super.key});

  final PageController _pageController = PageController();

  void _navigateToNextPage(WidgetRef ref) {
    final stepState = ref.read(pageNotifierProvider);
    final stepNotifier = ref.read(pageNotifierProvider.notifier);

    if (stepState.currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      stepNotifier.nextStep();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepNotifier = ref.read(pageNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Progress"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStepIndicator(1, "SignUp", ref),
              _buildStepIndicator(2, "Address", ref),
              // _buildStepIndicator(2, "Verification", ref),
            ],
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                stepNotifier.state =
                    stepNotifier.state.copyWith(currentStep: index + 1);
              },
              children: [
                // Pages for each step

                SignUpForm(
                  onNext: () => _navigateToNextPage(ref),
                ),

                AddressForm(
                  onNext: () => _navigateToNextPage(ref),
                ),
                // const VerificationPage()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String title, WidgetRef ref) {
    final stepState = ref.watch(pageNotifierProvider);
    bool isActive = step == stepState.currentStep;
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          child: Text(
            step.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
