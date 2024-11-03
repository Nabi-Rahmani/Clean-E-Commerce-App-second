import 'package:e_clean_fcm/core/themes/app_theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomFormTexField extends ConsumerWidget {
  const CustomFormTexField({
    super.key,
    this.hintText,
    required this.validator,
    required this.onSaved,
    this.prefixIcon,
    required this.enableSuggestions,
    required this.textCapitalization,
    this.keyboardType,
    required this.obscureText,
  });

  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Widget? prefixIcon;
  final bool enableSuggestions;
  final bool autocorrect = true;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode =
        ref.watch(appThemeModeNotifierProvider.notifier).isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode ? Colors.black45 : Colors.grey[150],
          prefixIcon: prefixIcon,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.black12 : Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.black12 : Colors.white,
            ),
          ),
        ),
        // Add the validator and onSaved parameters
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
