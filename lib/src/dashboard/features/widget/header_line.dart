import 'package:flutter/material.dart';

import '../../../../global/style/app_colors.dart';

class HeaderLine extends StatelessWidget {
  const HeaderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.warning,
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
