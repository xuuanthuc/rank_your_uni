import 'dart:math';
import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/point_container.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../../global/enum/criteria.dart';
import '../../../../global/style/styles.dart';

class CriteriaItem extends StatelessWidget {
  final Criteria criteria;

  const CriteriaItem({
    super.key,
    required this.criteria,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final point = (Random().nextInt(5) + 1).toDouble();
    final heightSize = ResponsiveBuilder.setSize(
      context,
      extraSize: 20,
      tinySize: 10,
    );
    final widthSize = ResponsiveBuilder.setSize(
      context,
      extraSize: 40,
      largeSize: 35,
      mediumSize: 30,
      smallSize: 25,
      tinySize: 15,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: heightSize,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  height: heightSize,
                  width: widthSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: getColorProgress(index + 1, point),
                  ),
                );
              },
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 2),
            ),
          ),
          SizedBox(width: heightSize),
          const PointContainer.tiny(point: 0,),
          Expanded(
            child: Text(
              criteria.name(context),
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.titleLarge,
            ),
          ),
          const PointContainer.tiny(point: 0,),
          SizedBox(width: heightSize),
          SizedBox(
            height: heightSize,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  height: heightSize,
                  width: widthSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: getColorProgress(index + 1, point),
                  ),
                );
              },
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 2),
            ),
          ),
        ],
      ),
    );
  }

  Color getColorProgress(int index, double criteriaPoint) {
    Color color = AppColors.level0;
    if (index <= criteriaPoint && criteriaPoint >= 5.0) {
      color = AppColors.level5;
    } else if (index <= criteriaPoint && criteriaPoint >= 4.0) {
      color = AppColors.level4;
    } else if (index <= criteriaPoint && criteriaPoint >= 3.0) {
      color = AppColors.level3;
    } else if (index <= criteriaPoint && criteriaPoint >= 2.0) {
      color = AppColors.level2;
    } else if (index <= criteriaPoint && criteriaPoint >= 1.0) {
      color = AppColors.level1;
    } else if (index <= criteriaPoint && criteriaPoint > 0.0) {
      color = AppColors.level1;
    }
    return color;
  }
}
