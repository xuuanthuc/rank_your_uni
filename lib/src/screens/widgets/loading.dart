import 'package:flutter/material.dart';

class PrimaryCircularLoading extends StatelessWidget {
  final bool condition;
  final double? strokeWidth;

  const PrimaryCircularLoading(
    this.condition, {
    super.key,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return condition
        ? Center(
            child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(strokeWidth: strokeWidth ?? 7),
            ),
          )
        : const SizedBox(
            height: 35,
            width: 35,
          );
  }
}
