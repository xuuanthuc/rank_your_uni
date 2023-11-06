import 'dart:math';

import 'package:flutter/material.dart';

import '../../../global/style/styles.dart';

class PointContainer extends StatelessWidget {
  final double size;
  final double fontSize;

  const PointContainer.regular({
    super.key,
    this.size = 62,
    this.fontSize = 25,
  });

  const PointContainer.small({
    super.key,
    this.size = 55,
    this.fontSize = 23,
  });

  const PointContainer.medium({
    super.key,
    this.size = 70,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    final point = double.parse((Random().nextDouble() * 5).toStringAsFixed(1));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: getBackgroundPoint(point),
      ),
      margin: const EdgeInsets.all(7),
      width: size,
      height: size,
      child: Center(
        child: Text(
          point.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Angkor',
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }

  Color getBackgroundPoint(double point) {
    Color color = AppColors.level0;
    if (point >= 5.0) {
      color = AppColors.level5;
    } else if (point >= 4.0) {
      color = AppColors.level4;
    } else if (point >= 3.0) {
      color = AppColors.level3;
    } else if (point >= 2.0) {
      color = AppColors.level2;
    } else if (point >= 1.0) {
      color = AppColors.level1;
    } else if (point > 0.0) {
      color = AppColors.level1;
    }
    return color;
  }
}
