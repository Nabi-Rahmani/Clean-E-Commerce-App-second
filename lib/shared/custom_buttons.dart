// custom_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/custom_app_size.dart';

class CustomButton extends ConsumerWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final bool isLoading;
  final IconData? icon;
  final bool disabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.isLoading = false,
    this.icon,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final IsDarkMode = ref.watch(themeProvider).isDarkMode;
    return GestureDetector(
      onTap: disabled || isLoading ? null : onTap,
      child: Container(
        width: AppSizing.isMobile(context)
            ? MediaQuery.sizeOf(context).width * 0.8
            : MediaQuery.sizeOf(context).width,
        height: height ?? 50,
        decoration: BoxDecoration(
          color:
              disabled ? Colors.grey.shade300 : backgroundColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          boxShadow: [
            BoxShadow(
              color: (backgroundColor ?? Colors.blue).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? Colors.white,
                    ),
                    strokeWidth: 2.5,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: textColor ?? Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// First, modify AppButtons class to be ConsumerWidget
class AppButtons {
  // Primary button with theme awareness
  static Widget primary({
    required String text,
    required VoidCallback onTap,
    bool isLoading = false,
    IconData? icon,
    bool disabled = false,
    required Color? backgroundColor,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          text: text,
          onTap: onTap,
          backgroundColor: backgroundColor,
          isLoading: isLoading,
          icon: icon,
          disabled: disabled,
        );
      },
    );
  }

  // Secondary button with theme awareness
  static Widget secondary({
    required String text,
    required VoidCallback onTap,
    bool isLoading = false,
    IconData? icon,
    bool disabled = false,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          text: text,
          onTap: onTap,
          backgroundColor: Colors.white,
          textColor: Colors.blue,
          borderRadius: 12,
          height: 48,
          isLoading: isLoading,
          icon: icon,
          disabled: disabled,
        );
      },
    );
  }

  // Success button with theme awareness
  static Widget success({
    required String text,
    required VoidCallback onTap,
    bool isLoading = false,
    IconData? icon,
    bool disabled = false,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          text: text,
          onTap: onTap,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          borderRadius: 12,
          height: 48,
          isLoading: isLoading,
          icon: icon,
          disabled: disabled,
        );
      },
    );
  }

  // Danger button with theme awareness
  static Widget danger({
    required String text,
    required VoidCallback onTap,
    bool isLoading = false,
    IconData? icon,
    bool disabled = false,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          text: text,
          onTap: onTap,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          borderRadius: 12,
          height: 48,
          isLoading: isLoading,
          icon: icon,
          disabled: disabled,
        );
      },
    );
  }

  // Outline button with theme awareness
  static Widget outline({
    required String text,
    required VoidCallback onTap,
    Color? borderColor,
    bool isLoading = false,
    IconData? icon,
    bool disabled = false,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          text: text,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          textColor: Colors.amber,
          borderRadius: 12,
          height: 48,
          isLoading: isLoading,
          icon: icon,
          disabled: disabled,
        );
      },
    );
  }
}
