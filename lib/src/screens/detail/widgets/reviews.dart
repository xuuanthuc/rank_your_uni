import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/utilities/format.dart';
import 'package:template/src/models/response/review.dart';
import 'package:template/src/screens/detail/bloc/detail_cubit.dart';
import 'package:template/src/screens/detail/report_review_form.dart';
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
      child: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      text.reviewCount(state.university?.totalReviews ?? 0),
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: (((index + 1) % 3) == 0) ? 75 : 0,
                    ),
                    child: ReviewItem(
                        review: (state.university?.reviews ?? [])[index]),
                  );
                },
                itemCount: state.university?.reviews?.length ?? 0,
                separatorBuilder: (_, __) => const SizedBox(height: 30),
              ),
              const SizedBox(height: 75),
              // SizedBox(
              //   width: 250,
              //   child: AppButton(
              //     onTap: () {},
              //     title: text.seeMore,
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final Review review;

  const ReviewItem({super.key, required this.review});

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
              // const MyReview(),
              OverallPoint(review: review),
              const SizedBox(height: 15),
              ReviewContent(
                onReport: () => _onReport(context),
                review: review,
              ),
            ],
          ),
          child: Column(
            children: [
              // const MyReview(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverallPoint(review: review),
                  const SizedBox(width: 35),
                  Expanded(
                    child: ReviewContent(
                      onReport: () => _onReport(context),
                      review: review,
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
              SelectionContainer.disabled(
                child: MouseRegion(
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
  final Review review;
  final Function onReport;

  const ReviewContent({
    super.key,
    required this.onReport,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewDate(review: review),
        const SizedBox(height: 14),
        ReviewDescription(review: review),
        const SizedBox(height: 20),
        ResponsiveBuilder(
          smallView: Column(
            children: [
              CriteriaItem(
                criteria: Criteria.reputation,
                review: review,
              ),
              CriteriaItem(
                criteria: Criteria.competition,
                review: review,
              ),
              CriteriaItem(
                criteria: Criteria.internet,
                review: review,
              ),
              CriteriaItem(
                criteria: Criteria.location,
                review: review,
              ),
              CriteriaItem(
                criteria: Criteria.favorite,
                review: review,
              ),
              CriteriaItem(
                criteria: Criteria.infrastructure,
                review: review,
              ),
              CriteriaItem(
                criteria: Criteria.clubs,
                review: review,
              ),
              CriteriaItem(
                criteria: Criteria.food,
                review: review,
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
                      review: review,
                    ),
                    CriteriaItem(
                      criteria: Criteria.competition,
                      review: review,
                    ),
                    CriteriaItem(
                      criteria: Criteria.internet,
                      review: review,
                    ),
                    CriteriaItem(
                      criteria: Criteria.location,
                      review: review,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  children: [
                    CriteriaItem(
                      criteria: Criteria.favorite,
                      review: review,
                    ),
                    CriteriaItem(
                      criteria: Criteria.infrastructure,
                      review: review,
                    ),
                    CriteriaItem(
                      criteria: Criteria.clubs,
                      review: review,
                    ),
                    CriteriaItem(
                      criteria: Criteria.food,
                      review: review,
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
  final Review review;

  const ReviewDescription({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      review.content ?? '',
      style: theme.primaryTextTheme.bodyMedium,
    );
  }
}

class ReviewDate extends StatelessWidget {
  final Review review;

  const ReviewDate({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          Formatter.vnDdMMMyyyy(review.reviewDate ?? ''),
          style: theme.primaryTextTheme.titleLarge,
        ),
      ],
    );
  }
}

class OverallPoint extends StatelessWidget {
  final Review review;

  const OverallPoint({super.key, required this.review});

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
        ResponsiveBuilder(
          tinyView: PointContainer.small(
            point: review.averagePointPerReview ?? 0,
          ),
          child: PointContainer.medium(
            point: review.averagePointPerReview ?? 0,
          ),
        ),
      ],
    );
  }
}

class CriteriaItem extends StatelessWidget {
  final Criteria criteria;
  final Review review;

  const CriteriaItem({
    super.key,
    required this.criteria,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  height: 16,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: getColorProgress(
                        index + 1, getReviewPoint(review, criteria)),
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

  getReviewPoint(Review review, Criteria criteria) {
    switch (criteria) {
      case Criteria.reputation:
        return review.reputation ?? 0;
      case Criteria.competition:
        return review.competition ?? 0;

      case Criteria.location:
        return review.location ?? 0;

      case Criteria.internet:
        return review.internet ?? 0;

      case Criteria.favorite:
        return review.favourite ?? 0;

      case Criteria.infrastructure:
        return review.facilities ?? 0;

      case Criteria.clubs:
        return review.clubs ?? 0;

      case Criteria.food:
        return review.food ?? 0;
      default:
        return 0.0;
    }
  }
}
