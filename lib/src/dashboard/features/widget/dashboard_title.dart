import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DashboardTitle extends StatelessWidget {
  final String title;

  const DashboardTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: AutoSizeText(
        title,
        minFontSize: 16,
        maxLines: 1,
        style: Theme.of(context).primaryTextTheme.displayLarge,
      ),
    );
  }
}
