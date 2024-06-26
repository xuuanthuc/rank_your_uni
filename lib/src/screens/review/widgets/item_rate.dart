import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/global/enum/rating_point.dart';
import '../../../../global/style/styles.dart';
import '../../../../global/enum/criteria.dart';
import '../bloc/item_criteria_cubit.dart';

class CriteriaReviewLevel extends StatelessWidget {
  final Criteria criteria;
  final int? initialValue;
  final Function(CriteriaRated) onUpdate;

  const CriteriaReviewLevel({
    super.key,
    this.initialValue,
    required this.criteria,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCriteriaCubit(),
      child: CriteriaReviewView(
        criteria: criteria,
        onUpdate: onUpdate,
        initialValue: initialValue,
      ),
    );
  }
}

class CriteriaReviewView extends StatefulWidget {
  final Criteria criteria;
  final Function(CriteriaRated) onUpdate;
  final int? initialValue;

  const CriteriaReviewView({
    super.key,
    this.initialValue,
    required this.criteria,
    required this.onUpdate,
  });

  @override
  State<CriteriaReviewView> createState() => _CriteriaReviewViewState();
}

class _CriteriaReviewViewState extends State<CriteriaReviewView> {
  @override
  void initState() {
    if (widget.initialValue != null) {
      context.read<ItemCriteriaCubit>().onRate(CriteriaRated(
            criteria: widget.criteria,
            point: getPoint(widget.initialValue! - 1),
          ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    const double sliderItemWidth = 60;
    const double sliderItemHeight = 36;
    const double sliderItemSpacer = 4;

    return BlocListener<ItemCriteriaCubit, ItemCriteriaState>(
      listener: (context, state) {
        if (state.status == MouseStatus.none) {
          if (state.rated != null && state.rated?.point != null) {
            widget.onUpdate(state.rated!);
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 25 / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: theme.primaryColor,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20).copyWith(bottom: 0),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.criteria.description(context),
                      style: theme.primaryTextTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '*',
                    style: theme.primaryTextTheme.labelLarge?.copyWith(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20).copyWith(top: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.criteria.subDescription(context),
                      style: theme.primaryTextTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ItemCriteriaCubit, ItemCriteriaState>(
              builder: (context, state) {
                return SizedBox(
                  height: sliderItemHeight,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        onEnter: (detail) {
                          context
                              .read<ItemCriteriaCubit>()
                              .onStartHover(index + 1);
                        },
                        onExit: (detail) {
                          context.read<ItemCriteriaCubit>().onEndHover();
                        },
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<ItemCriteriaCubit>()
                                .onRate(CriteriaRated(
                                  criteria: widget.criteria,
                                  point: getPoint(index),
                                ));
                          },
                          child: Container(
                            height: sliderItemHeight,
                            width: sliderItemWidth,
                            decoration: BoxDecoration(
                              color: state.status == MouseStatus.hover
                                  ? (index + 1) > (state.indexHover ?? 0)
                                      ? AppColors.primaryShadow
                                      : getColorProgress(
                                          index,
                                          state.status ?? MouseStatus.none,
                                          widget.criteria,
                                        ).withOpacity(
                                          state.status == MouseStatus.hover
                                              ? 0.7
                                              : 1)
                                  : state.rated != null
                                      ? getColorRated(index, state.rated!)
                                      : (index + 1) > (state.indexHover ?? 0)
                                          ? AppColors.primaryShadow
                                          : getColorProgress(
                                              index,
                                              state.status ?? MouseStatus.none,
                                              widget.criteria,
                                            ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: sliderItemSpacer),
                    itemCount: 5,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: SizedBox(
                height: sliderItemHeight,
                child: BlocBuilder<ItemCriteriaCubit, ItemCriteriaState>(
                  buildWhen: (prev, curt) => prev.rated != curt.rated,
                  builder: (context, state) {
                    if (state.rated == null) {
                      return SizedBox(
                        width: sliderItemSpacer * 4 + sliderItemWidth * 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.criteria == Criteria.hard
                                  ? text.easyAsPie
                                  : text.awful,
                              style: theme.primaryTextTheme.bodyLarge,
                            ),
                            Text(
                              widget.criteria == Criteria.hard
                                  ? text.painful
                                  : text.excellent,
                              style: theme.primaryTextTheme.bodyLarge,
                            ),
                          ],
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: sliderItemHeight,
                          width: sliderItemHeight,
                          child: SvgPicture.asset(
                              state.rated!.point.iconPath(widget.criteria)),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.rated!.point.name(context, widget.criteria),
                          style: theme.primaryTextTheme.bodyLarge,
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getColorRated(int index, CriteriaRated rated) {
    Color color = AppColors.primaryShadow;

    if (rated.criteria == Criteria.hard) {
      if (rated.point.index >= index) {
        if (index == 0) {
          color = AppColors.level5;
        } else if (index <= 1) {
          color = AppColors.level4;
        } else if (index <= 2) {
          color = AppColors.level3;
        } else if (index <= 3) {
          color = AppColors.level2;
        } else if (index <= 4) {
          color = AppColors.level1;
        }
      }

      return color;
    } else {
      if (rated.point.index >= index) {
        if (index == 0) {
          color = AppColors.level1;
        } else if (index <= 1) {
          color = AppColors.level2;
        } else if (index <= 2) {
          color = AppColors.level3;
        } else if (index <= 3) {
          color = AppColors.level4;
        } else if (index <= 4) {
          color = AppColors.level5;
        }
      }
      return color;
    }
  }

  Color getColorProgress(int index, MouseStatus status, Criteria crit) {
    Color color = AppColors.primaryShadow;
    if (crit == Criteria.hard) {
      if (status == MouseStatus.hover) {
        if (index == 0) {
          color = AppColors.level5;
        } else if (index <= 1) {
          color = AppColors.level4;
        } else if (index <= 2) {
          color = AppColors.level3;
        } else if (index <= 3) {
          color = AppColors.level2;
        } else if (index <= 4) {
          color = AppColors.level1;
        }
      }
      return color;
    } else {
      if (status == MouseStatus.hover) {
        if (index == 0) {
          color = AppColors.level1;
        } else if (index <= 1) {
          color = AppColors.level2;
        } else if (index <= 2) {
          color = AppColors.level3;
        } else if (index <= 3) {
          color = AppColors.level4;
        } else if (index <= 4) {
          color = AppColors.level5;
        }
      }
      return color;
    }
  }

  RatePoint getPoint(int index) {
    RatePoint point = RatePoint.awful;
    switch (index) {
      case 0:
        point = RatePoint.awful;
        break;
      case 1:
        point = RatePoint.bad;
        break;
      case 2:
        point = RatePoint.medium;
        break;
      case 3:
        point = RatePoint.good;
        break;
      case 4:
        point = RatePoint.excellent;
        break;
    }
    return point;
  }
}
