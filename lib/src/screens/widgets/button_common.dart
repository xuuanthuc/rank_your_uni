import 'package:flutter/material.dart';
import 'package:template/global/style/app_colors.dart';

class AppButton extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool isOutline;
  final TextStyle? titleTextStyle;
  final EdgeInsetsGeometry? padding;
  final double? height;

  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isOutline = false,
    this.titleTextStyle,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextButton(
      onPressed: () => onTap(),
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        overlayColor: MaterialStateProperty.all(theme.colorScheme.surface),
        backgroundColor: MaterialStateProperty.all(
          isOutline ? Colors.transparent : theme.primaryColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(0),
            ),
            side: BorderSide(
              width: 2,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
      child: Container(
        height: height,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
        child: Center(
          child: Text(
            title,
            style: titleTextStyle ??
                theme.primaryTextTheme.labelLarge
                    ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
