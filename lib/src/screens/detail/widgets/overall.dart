import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/global/utilities/criteria.dart';
import 'package:template/src/screens/widgets/point_container.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../../global/style/styles.dart';
import '../../widgets/button_common.dart';

class UniversityOverview extends StatelessWidget {
  const UniversityOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: ResponsiveBuilder.setHorizontalPadding(context)),
          constraints: const BoxConstraints(
            maxWidth: Public.laptopSize,
          ),
          child: const ResponsiveBuilder(
            smallView: Column(
              children: [
                SizedBox(height: 40),
                OverallPoint(),
                SizedBox(height: 14),
                UniversityName(),
                SizedBox(height: 14),
                UniversityAddress(),
                SizedBox(height: 28),
                ActionReviewAndCompare(),
                SizedBox(height: 40),
                ReviewCriteria(criteria: Criteria.reputation),
                ReviewCriteria(criteria: Criteria.competition),
                ReviewCriteria(criteria: Criteria.internet),
                ReviewCriteria(criteria: Criteria.location),
                ReviewCriteria(criteria: Criteria.favorite),
                ReviewCriteria(criteria: Criteria.infrastructure),
                ReviewCriteria(criteria: Criteria.clubs),
                ReviewCriteria(criteria: Criteria.food),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OverallPoint(),
                      SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UniversityAddress(),
                            SizedBox(height: 14),
                            UniversityName(),
                            SizedBox(height: 28),
                            ActionReviewAndCompare(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ReviewCriteria(criteria: Criteria.reputation),
                            ReviewCriteria(criteria: Criteria.competition),
                            ReviewCriteria(criteria: Criteria.internet),
                            ReviewCriteria(criteria: Criteria.location),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: VerticalDivider(
                          color: AppColors.grey,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ReviewCriteria(criteria: Criteria.favorite),
                            ReviewCriteria(
                                criteria: Criteria.infrastructure),
                            ReviewCriteria(criteria: Criteria.clubs),
                            ReviewCriteria(criteria: Criteria.food),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActionReviewAndCompare extends StatelessWidget {
  const ActionReviewAndCompare({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return ResponsiveBuilder(
      smallView: Column(
        children: [
          AppButton(
            onTap: () => {},
            title: text.reviewThisUniversity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            onTap: () => {},
            title: text.compareUniversity,
            isOutline: true,
            borderColor: theme.primaryColor,
            titleTextStyleColor: theme.primaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
        ],
      ),
      child: Row(
        children: [
          AppButton(
            onTap: () => {},
            title: text.reviewThisUniversity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
          const SizedBox(width: 16),
          AppButton(
            onTap: () => {},
            title: text.compareUniversity,
            isOutline: true,
            borderColor: theme.primaryColor,
            titleTextStyleColor: theme.primaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class UniversityAddress extends StatelessWidget {
  const UniversityAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          'Cầu Giấy, Hà Nội',
          style: theme.primaryTextTheme.bodyLarge,
        ),
      ],
    );
  }
}

class UniversityName extends StatelessWidget {
  const UniversityName({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoSizeText(
      'Trường Đại học Khoa học Xã hội và Nhân văn - Đại học Quốc gia Thành Phố Hồ Chí Minh',
      style: theme.primaryTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 30,
      ),
      minFontSize: 20,
      maxLines: 3,
    );
  }
}

class OverallPoint extends StatelessWidget {
  const OverallPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 180,
      child: Stack(
        children: [
          SvgPicture.asset(AppImages.iPaint),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '5.0',
              style: TextStyle(
                fontFamily: "Angkor",
                fontSize: 70,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReviewCriteria extends StatelessWidget {
  final Criteria criteria;

  const ReviewCriteria({
    super.key,
    required this.criteria,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: SvgPicture.asset(
            criteria.iconPath,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            criteria.name(context),
            style: theme.primaryTextTheme.titleMedium,
          ),
        ),
        const PointContainer.small()
      ],
    );
  }
}
