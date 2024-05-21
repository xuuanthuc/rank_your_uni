import 'package:flutter/material.dart';
import '../../../global/style/styles.dart';

class PointContainer extends StatelessWidget {
  final double point;
  final double size;
  final double fontSize;
  final bool hasColor;

  const PointContainer.regular(
      {super.key,
      required this.point,
      this.size = 62,
      this.fontSize = 25,
      this.hasColor = true});

  const PointContainer.small({
    super.key,
    required this.point,
    this.size = 55,
    this.fontSize = 23,
    this.hasColor = true,
  });

  const PointContainer.tiny({
    super.key,
    required this.point,
    this.size = 34,
    this.fontSize = 14,
    this.hasColor = true,
  });

  const PointContainer.medium({
    super.key,
    required this.point,
    this.size = 70,
    this.fontSize = 30,
    this.hasColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: getBackgroundPoint(hasColor ? point : 0),
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
