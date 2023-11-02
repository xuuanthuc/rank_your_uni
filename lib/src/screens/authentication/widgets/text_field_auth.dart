import 'package:flutter/material.dart';
import '../../../../global/style/styles.dart';


class AuthTextField extends StatelessWidget {
  final ThemeData theme;
  final AppLocalizations text;
  final String hintText;

  const AuthTextField({
    super.key,
    required this.theme,
    required this.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: theme.primaryTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
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
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}