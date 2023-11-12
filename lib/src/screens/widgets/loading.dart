import 'package:flutter/material.dart';

class LoadingCommon extends StatelessWidget {
  final bool condition;

  const LoadingCommon(this.condition, {super.key});

  @override
  Widget build(BuildContext context) {
    return condition
        ? const Center(
            child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(strokeWidth: 7),
            ),
          )
        : const SizedBox(
            height: 35,
            width: 35,
          );
  }
}
