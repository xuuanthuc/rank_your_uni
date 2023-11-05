import 'dart:math';

import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

class UniversityCard extends StatelessWidget {
  final Function onTap;

  const UniversityCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width > Public.laptopSize
                ? Public.tabletSize
                : Public.laptopSize,
          ),
          margin:
              const EdgeInsets.symmetric(vertical: 25 / 2, horizontal: 50),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          color: AppColors.primaryShadow,
          child: GestureDetector(
            onTap: () => onTap(),
            child: const ResponsiveBuilder(
              tinyView: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingQuality(),
                      UniversityAddress(),
                    ],
                  ),
                  UniversityName(),
                ],
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RatingQuality(),
                      SizedBox(width: 40),
                      UniversityName(),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: UniversityAddress(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingQuality extends StatelessWidget {
  const RatingQuality({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          text.quality,
          style: theme.primaryTextTheme.labelLarge?.copyWith(
            fontSize: 14,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: getBackgroundPoint(Random().nextDouble() * 5),
          ),
          margin: const EdgeInsets.all(7),
          width: 62,
          height: 62,
          child: const Center(
            child: Text(
              '5.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Angkor',
                fontSize: 25,
              ),
            ),
          ),
        ),
        Text(text.reviewCount(50)),
      ],
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

class UniversityName extends StatelessWidget {
  const UniversityName({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flexible(
      child: Text(
        'Trường Đại học Khoa học Xã hội và Nhân văn - Đại học Quốc gia Thành Phố Hồ Chí Minh',
        style: theme.primaryTextTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class UniversityAddress extends StatelessWidget {
  const UniversityAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Cầu Giấy, Hà Nội");
  }
}
