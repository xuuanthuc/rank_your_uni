import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const DashboardButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: () => onPressed(),
      icon: child,
    );
  }
}
