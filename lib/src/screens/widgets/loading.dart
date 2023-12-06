import 'package:flutter/material.dart';

class PrimaryCircularLoading extends StatelessWidget {
  final bool condition;
  final double? strokeWidth;
  final Color? strokeColor;

  const PrimaryCircularLoading(
    this.condition, {
    super.key,
    this.strokeWidth,
    this.strokeColor,
  });

  @override
  Widget build(BuildContext context) {
    return condition
        ? Center(
            child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth ?? 7,
                color: strokeColor,
              ),
            ),
          )
        : const SizedBox(
            height: 35,
            width: 35,
          );
  }
}
