import 'package:flutter/material.dart';

class AuthFormLabel extends StatelessWidget {
  final String text;
  final ThemeData theme;

  const AuthFormLabel(
      this.theme, {
        super.key,
        required this.text,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text,
              style: theme.primaryTextTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
