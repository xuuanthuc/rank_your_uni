import 'package:flutter/material.dart';
import '../../../../global/style/styles.dart';

class AuthTextField extends StatelessWidget {
  final ThemeData theme;
  final AppLocalizations text;
  final String hintText;
  final TextEditingController controller;

  const AuthTextField({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: theme.primaryTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.primaryTextTheme.bodyLarge
            ?.copyWith(color: AppColors.textGrey),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.grey, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.grey, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.error, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.error, width: 1)),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    );
  }
}
