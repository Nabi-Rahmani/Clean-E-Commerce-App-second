// ignore_for_file: must_be_immutable, prefer_final_fields, unused_field, avoid_print
import 'dart:async';

import 'package:e_clean_fcm/core/constants/app_const_colors.dart';
import 'package:e_clean_fcm/core/constants/app_sizes.dart';
import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:e_clean_fcm/core/util/string_hardcode.dart';
import 'package:e_clean_fcm/features/auth/home/sing_up_page.dart';
import 'package:e_clean_fcm/features/auth/services/auth_form_notifier.dart';
import 'package:e_clean_fcm/features/auth/services/auth_notifier.dart';

import 'package:e_clean_fcm/features/auth/widgets/validation.dart';
import 'package:e_clean_fcm/shared/custom_buttons.dart';
import 'package:e_clean_fcm/shared/custom_textfield.dart';
import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SignUpOrLogin extends ConsumerWidget {
  SignUpOrLogin({super.key});

  final _formKey = GlobalKey<FormState>();
  void submitSignUpData(WidgetRef ref) {
    final isValid = _formKey.currentState?.validate();
    print('Form valid: $isValid'); // Should be true

    if (!isValid!) {
      return; // Return if the form is not valid
    }

    // Only save if the form is valid
    _formKey.currentState?.save();

    final formState = ref.read(authFormNotifierProvider);

    // Print saved values to verify they are being captured
    // print('Email: ${formState.email}');
    // print('Password: ${formState.password}');
    // print('UserName: ${formState.userName}');
    // print('LastName: ${formState.lastName}');
    // print('ImageFile: ${formState.imageFile}');

    if (formState.isAuthenticaion) {
      ref.watch(authFormNotifierProvider.notifier).toggleisAuthenticaion();
    }
    // Check the sign-up condition
    if (formState.isLogin ||
        !formState.isLogin && formState.imageFile == null) {
      ref.read(authNotifierProvider.notifier).signInWithEmailAndPassword(
            formState.email!,
            formState.password!,
          );
      final trackUser = ref.watch(analyticsFacadeProvider);
      unawaited(trackUser.trackAppOpened());
    } else {}
    if (!formState.isAuthenticaion) {
      ref.watch(authFormNotifierProvider.notifier).toggleisAuthenticaion();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authFormNotifierProvider);
    final formNotifier = ref.read(authFormNotifierProvider.notifier);
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Email
                CustomFormTexField(
                  hintText: 'Email Adress'.hardcoded,
                  validator: FormValidators.validateEmail,
                  onSaved: (value) => formNotifier.setEmail(value!),
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  obscureText: false,
                ),
                // Password
                CustomFormTexField(
                  hintText: 'Password'.hardcoded,
                  validator: FormValidators.validatePassword,
                  onSaved: (value) => formNotifier.setPassword(value!),
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  obscureText: false,
                ),
                if (formState.isAuthenticaion)
                  const CircularProgressIndicator(
                    color: Colors.black,
                  ),
                AppButtons.primary(
                  text: 'Login',
                  onTap: () => submitSignUpData(ref),
                  backgroundColor: isDarkMode ? Colors.black38 : Colors.black87,
                ),
                const Gap(Sizes.p16),
                GestureDetector(
                  onTap: () => formNotifier.toggleAuthMode(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Are you new?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => SignUpProgress(),
                              ));
                        },
                        child: const Text(
                          'create account',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            decoration:
                                TextDecoration.underline, // Add this line
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// // ignore_for_file: must_be_immutable, prefer_final_fields, unused_field, avoid_print
// import 'dart:async';

// import 'package:e_clean_fcm/core/constants/app_sizes.dart';
// import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
// import 'package:e_clean_fcm/core/util/string_hardcode.dart';
// import 'dart:io';
// import 'package:e_clean_fcm/features/auth/models/user_model.dart';
// import 'package:e_clean_fcm/features/auth/services/auth_form_notifier.dart';
// import 'package:e_clean_fcm/features/auth/services/auth_notifier.dart';
// import 'package:e_clean_fcm/features/auth/widgets/image_pickers.dart';
// import 'package:e_clean_fcm/features/auth/widgets/validation.dart';
// import 'package:e_clean_fcm/shared/custom_buttons.dart';
// import 'package:e_clean_fcm/shared/custom_textfield.dart';
// import 'package:e_clean_fcm/src/monitoring/analytics_facade.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';

// class SignUpOrLogin extends ConsumerWidget {
//   SignUpOrLogin({super.key});

//   final _formKey = GlobalKey<FormState>();
//   void submitSignUpData(WidgetRef ref) {
//     final isValid = _formKey.currentState?.validate();
//     print('Form valid: $isValid'); // Should be true

//     if (!isValid!) {
//       return; // Return if the form is not valid
//     }

//     // Only save if the form is valid
//     _formKey.currentState?.save();

//     final formState = ref.read(authFormNotifierProvider);

//     // Print saved values to verify they are being captured
//     // print('Email: ${formState.email}');
//     // print('Password: ${formState.password}');
//     // print('UserName: ${formState.userName}');
//     // print('LastName: ${formState.lastName}');
//     // print('ImageFile: ${formState.imageFile}');

//     if (formState.isAuthenticaion) {
//       ref.watch(authFormNotifierProvider.notifier).toggleisAuthenticaion();
//     }
//     // Check the sign-up condition
//     if (formState.isLogin ||
//         !formState.isLogin && formState.imageFile == null) {
//       ref.read(authNotifierProvider.notifier).signInWithEmailAndPassword(
//             formState.email!,
//             formState.password!,
//           );
//       final trackUser = ref.watch(analyticsFacadeProvider);
//       unawaited(trackUser.trackAppOpened());
//     } else {
//       final user = UserModels(
//         userid: '', // Will be set after signup
//         email: formState.email!,
//         password: formState.password!,
//         userName: formState.userName!,
//         lastName: formState.lastName!,
//         imageFile: formState.imageFile,
//       );

//       // Call sign up method
//       print('Attempting to sign up with email: ${user.email}');
//       ref.read(authNotifierProvider.notifier).signUpWithEmailAndPassword(user);
//     }
//     if (!formState.isAuthenticaion) {
//       ref.watch(authFormNotifierProvider.notifier).toggleisAuthenticaion();
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formState = ref.watch(authFormNotifierProvider);
//     final formNotifier = ref.read(authFormNotifierProvider.notifier);
//     final isDarkMode =
//         ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 if (!formState.isLogin)
//                   UserImagePicker(
//                     onPickedImageFile: (File pickImageFile) {
//                       formNotifier.setImageFile(pickImageFile);
//                     },
//                   ),
//                 // Name
//                 if (!formState.isLogin)
//                   CustomFormTexField(
//                     hintText: 'Name'.hardcoded,
//                     validator: FormValidators.validateUsername,
//                     onSaved: (value) => formNotifier.setUserName(value!),
//                     enableSuggestions: false,
//                     textCapitalization: TextCapitalization.none,
//                     obscureText: false,
//                   ),
//                 // Last Name
//                 if (!formState.isLogin)
//                   CustomFormTexField(
//                     hintText: 'Last Nmae'.hardcoded,
//                     validator: FormValidators.validateUsername,
//                     onSaved: (value) => formNotifier.setLastName(value!),
//                     enableSuggestions: false,
//                     textCapitalization: TextCapitalization.none,
//                     obscureText: false,
//                   ),
//                 // Email
//                 CustomFormTexField(
//                   hintText: 'Email Adress'.hardcoded,
//                   validator: FormValidators.validateEmail,
//                   onSaved: (value) => formNotifier.setEmail(value!),
//                   enableSuggestions: false,
//                   textCapitalization: TextCapitalization.none,
//                   obscureText: false,
//                 ),
//                 // Password
//                 CustomFormTexField(
//                   hintText: 'Password'.hardcoded,
//                   validator: FormValidators.validatePassword,
//                   onSaved: (value) => formNotifier.setPassword(value!),
//                   enableSuggestions: false,
//                   textCapitalization: TextCapitalization.none,
//                   obscureText: false,
//                 ),
//                 if (formState.isAuthenticaion)
//                   const CircularProgressIndicator(
//                     color: Colors.black,
//                   ),
//                 AppButtons.primary(
//                   text: formState.isLogin ? 'Login' : 'Sign Up',
//                   onTap: () => submitSignUpData(ref),
//                   backgroundColor: isDarkMode ? Colors.black38 : Colors.black87,
//                 ),
//                 const Gap(Sizes.p16),
//                 GestureDetector(
//                   onTap: () => formNotifier.toggleAuthMode(),
//                   child: Text(
//                     formState.isLogin
//                         ? 'Create an account'
//                         : 'I already have an account',
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
