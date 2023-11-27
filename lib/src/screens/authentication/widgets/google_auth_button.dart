import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import '../../widgets/responsive_builder.dart';


class AuthWithGoogleButton extends StatelessWidget {
  final ThemeData theme;
  final String text;
  final Function onAuthWithGoogle;

  const AuthWithGoogleButton({
    super.key,
    required this.theme,
    required this.text,
    required this.onAuthWithGoogle,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onAuthWithGoogle(),
        child: ResponsiveBuilder(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: AppColors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(AppImages.iGoogleLogo),
                ),
                const SizedBox(width: 14),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: theme.primaryTextTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}