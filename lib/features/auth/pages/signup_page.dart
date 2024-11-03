// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:e_clean_fcm/features/auth/models/user_model.dart';
import 'package:e_clean_fcm/features/auth/services/auth_form_notifier.dart';
import 'package:e_clean_fcm/features/auth/services/auth_notifier.dart';
import 'package:e_clean_fcm/features/auth/widgets/image_pickers.dart';
import 'package:e_clean_fcm/features/auth/widgets/validation.dart';
import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpForm extends ConsumerWidget {
  final VoidCallback onNext;

  SignUpForm({
    super.key,
    required this.onNext,
  });

  final _formKey = GlobalKey<FormState>();

  Future<void> submitSignUpData(WidgetRef ref) async {
    final isValid = _formKey.currentState?.validate();
    print('Form valid: $isValid');

    if (!isValid!) {
      return;
    }

    // Save form data
    _formKey.currentState?.save();

    final formState = ref.read(authFormNotifierProvider);

    if (formState.isAuthenticaion) {
      ref.watch(authFormNotifierProvider.notifier).toggleisAuthenticaion();
    }

    final trackUser = ref.watch(analyticsFacadeProvider);
    unawaited(trackUser.trackAppOpened());

    try {
      final user = UserModels(
        userid: '',
        email: formState.email!,
        password: formState.password!,
        userName: formState.userName!,
        lastName: formState.lastName!,
        imageFile: formState.imageFile,
      );

      // Call sign up method and wait for it to complete
      await ref
          .read(authNotifierProvider.notifier)
          .signUpWithEmailAndPassword(user);

      if (!formState.isAuthenticaion) {
        ref.watch(authFormNotifierProvider.notifier).toggleisAuthenticaion();
      }

      // Only navigate if sign up was successful
      onNext();
    } catch (e) {
      print('Error during sign up: $e');
      // Handle error (show snackbar, etc.)
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authFormNotifierProvider);
    final formNotifier = ref.read(authFormNotifierProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!formState.isLogin)
              UserImagePicker(
                onPickedImageFile: (File pickImageFile) {
                  formNotifier.setImageFile(pickImageFile);
                },
              ),
            const SizedBox(height: 24),

            // First Name
            _buildTextField(
              label: 'First Name',
              hint: 'Enter your first name',
              validator: FormValidators.validateText,
              onSaved: (name) => formNotifier.setUserName(name!),
            ),
            const SizedBox(height: 16),

            // Last Name
            _buildTextField(
              label: 'Last Name',
              hint: 'Enter your last name',
              validator: FormValidators.validateText,
              onSaved: (lasname) => formNotifier.setLastName(lasname!),
            ),
            const SizedBox(height: 16),

            // Email
            _buildTextField(
              label: 'Email',
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              validator: FormValidators.validateEmail,
              onSaved: (email) => formNotifier.setEmail(email!),
            ),
            const SizedBox(height: 16),

            // Password
            _buildTextField(
              label: 'Password',
              hint: 'Create a password',
              isPassword: true,
              validator: FormValidators.validatePassword,
              onSaved: (password) => formNotifier.setPassword(password!),
            ),
            const SizedBox(height: 8),

            // Password helper text
            const Text(
              'Password must be at least 6 characters long',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 24),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  submitSignUpData(ref);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
    required String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool isPassword = false,
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
          validator: validator,
          keyboardType: keyboardType,
          obscureText: isPassword,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
