import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/src/screens/detail/report_review_form.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/point_container.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

class ReviewsBuilder extends StatelessWidget {
  const ReviewsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveBuilder.setHorizontalPadding(context),
      ),
      constraints: const BoxConstraints(
        maxWidth: Public.laptopSize,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  text.reviewCount(50),
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: (((index + 1) % 3) == 0) ? 75 : 0,
                ),
                child: const ReviewItem(),
              );
            },
            itemCount: 20,
            separatorBuilder: (_, __) => const SizedBox(height: 30),
          ),
          const SizedBox(height: 75),
          SizedBox(
            width: 250,
            child: AppButton(
              onTap: () {},
              title: text.seeMore,
            ),
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key});

  Future<void> _onReport(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const ReportReviewForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        color: AppColors.primaryShadow,
        constraints: const BoxConstraints(maxWidth: Public.tabletSize),
        padding: const EdgeInsets.all(22).copyWith(bottom: 10),
        child: ResponsiveBuilder(
          mediumView: Column(
            children: [
              const MyReview(),
              const OverallPoint(),
              const SizedBox(height: 15),
              ReviewContent(
                onReport: () => _onReport(context),
              ),
            ],
          ),
          child: Column(
            children: [
              const MyReview(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OverallPoint(),
                  const SizedBox(width: 35),
                  Expanded(
                    child: ReviewContent(
                      onReport: () => _onReport(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyReview extends StatelessWidget {
  const MyReview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Visibility(
      visible: true,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                  style: theme.primaryTextTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      SvgPicture.asset(AppImages.iEdit),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(context)!.edit,
                        style: theme.primaryTextTheme.labelLarge,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: DashLine(),
          ),
        ],
      ),
    );
  }
}

class DashLine extends StatelessWidget {
  const DashLine({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class ReviewContent extends StatelessWidget {
  final Function onReport;

  const ReviewContent({
    super.key,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReviewDate(),
        const SizedBox(height: 14),
        const ReviewDescription(),
        const SizedBox(height: 20),
        const ResponsiveBuilder(
          smallView: Column(
            children: [
              CriteriaItem(
                criteria: Criteria.reputation,
              ),
              CriteriaItem(
                criteria: Criteria.competition,
              ),
              CriteriaItem(
                criteria: Criteria.internet,
              ),
              CriteriaItem(
                criteria: Criteria.location,
              ),
              CriteriaItem(
                criteria: Criteria.favorite,
              ),
              CriteriaItem(
                criteria: Criteria.infrastructure,
              ),
              CriteriaItem(
                criteria: Criteria.clubs,
              ),
              CriteriaItem(
                criteria: Criteria.food,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CriteriaItem(
                      criteria: Criteria.reputation,
                    ),
                    CriteriaItem(
                      criteria: Criteria.competition,
                    ),
                    CriteriaItem(
                      criteria: Criteria.internet,
                    ),
                    CriteriaItem(
                      criteria: Criteria.location,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  children: [
                    CriteriaItem(
                      criteria: Criteria.favorite,
                    ),
                    CriteriaItem(
                      criteria: Criteria.infrastructure,
                    ),
                    CriteriaItem(
                      criteria: Criteria.clubs,
                    ),
                    CriteriaItem(
                      criteria: Criteria.food,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Tooltip(
              message: text.helpful,
              child: IconButton(
                onPressed: () {},
                icon: SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(AppImages.iLike),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              '40',
              style: theme.primaryTextTheme.labelLarge,
            ),
            const SizedBox(width: 30),
            Tooltip(
              message: text.notHelpful,
              child: IconButton(
                onPressed: () {},
                icon: SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(AppImages.iDislike),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              '40',
              style: theme.primaryTextTheme.labelLarge,
            ),
            const Spacer(),
            Tooltip(
              message: text.report,
              child: IconButton(
                onPressed: () => onReport(),
                icon: SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(AppImages.iFlag),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ReviewDescription extends StatelessWidget {
  const ReviewDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      Random().nextInt(3) == 2
          ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
          : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ',
      style: theme.primaryTextTheme.bodyMedium,
    );
  }
}

class ReviewDate extends StatelessWidget {
  const ReviewDate({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '27 tháng 03, 2023',
          style: theme.primaryTextTheme.labelLarge,
        ),
      ],
    );
  }
}

class OverallPoint extends StatelessWidget {
  const OverallPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text.overall,
          style: theme.primaryTextTheme.bodyLarge,
        ),
        const SizedBox(height: 7),
        const ResponsiveBuilder(
          tinyView: PointContainer.small(),
          child: PointContainer.medium(),
        ),
      ],
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            criteria.name(context),
            style: theme.primaryTextTheme.titleLarge,
          ),
          SizedBox(
            height: 16,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  height: 16,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: getColorProgress(index + 1, point),
                  ),
                );
              },
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 2),
            ),
          )
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
