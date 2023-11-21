import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/compare/bloc/compare_cubit.dart';
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
          BlocBuilder<CompareCubit, CompareState>(
            builder: (context, state) {
              return SizedBox(
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
                        color: getColorProgress(
                          index + 1,
                          getReviewPoint(state.firstUniversity, criteria),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(width: 2),
                ),
              );
            },
          ),
          SizedBox(width: heightSize),
          BlocBuilder<CompareCubit, CompareState>(
            builder: (context, state) {
              return PointContainer.tiny(
                point: getReviewPoint(state.firstUniversity, criteria),
              );
            },
          ),
          Expanded(
            child: Text(
              criteria.name(context),
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.titleLarge,
            ),
          ),
          BlocBuilder<CompareCubit, CompareState>(
            builder: (context, state) {
              return PointContainer.tiny(
                point: getReviewPoint(state.compareWith, criteria),
              );
            },
          ),
          SizedBox(width: heightSize),
          BlocBuilder<CompareCubit, CompareState>(
            builder: (context, state) {
              return SizedBox(
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
                        color: getColorProgress(
                          index + 1,
                          getReviewPoint(state.compareWith, criteria),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                  separatorBuilder: (_, __) => const SizedBox(width: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  getReviewPoint(University? university, Criteria criteria) {
    switch (criteria) {
      case Criteria.reputation:
        return university?.reputationAvg ?? 0;
      case Criteria.competition:
        return university?.competitionLevelAvg ?? 0;

      case Criteria.location:
        return university?.locationAvg ?? 0;

      case Criteria.internet:
        return university?.internetAvg ?? 0;

      case Criteria.favorite:
        return university?.favoriteAvg ?? 0;

      case Criteria.infrastructure:
        return university?.facilitiesAvg ?? 0;

      case Criteria.clubs:
        return university?.clubsAvg ?? 0;

      case Criteria.food:
        return university?.foodAvg ?? 0;
      default:
        return 0.0;
    }
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
