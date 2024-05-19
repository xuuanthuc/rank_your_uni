import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/utilities/format.dart';
import 'package:template/global/utilities/toast.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/review.dart';
import 'package:template/src/screens/detail/bloc/detail_university_cubit.dart';
import 'package:template/src/screens/detail/bloc/report_cubit.dart';
import 'package:template/src/screens/detail/bloc/review_item_cubit.dart';
import 'package:template/src/screens/detail/report_review_form.dart';
import 'package:template/src/screens/widgets/loading.dart';
import 'package:template/src/screens/widgets/point_container.dart';
import 'package:template/src/screens/widgets/required_login_dialog.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../../global/routes/route_keys.dart';
import '../../../../global/storage/storage_keys.dart';
import '../../../../global/storage/storage_provider.dart';
import '../../../models/request/edit_review_param.dart';
import '../../../models/response/profile.dart';
import '../../../models/response/university.dart';
import '../../widgets/primary_button.dart';

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
      child: BlocBuilder<DetailUniversityCubit, DetailUniversityState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(mainAxisSize: MainAxisSize.max),
              const SizedBox(height: 20),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: Public.tabletSize,
                ),
                child: Row(
                  children: [
                    if (state.status == DetailStatus.loading)
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: PrimaryCircularLoading(
                          state.status == DetailStatus.loading,
                          strokeWidth: 5,
                        ),
                      ),
                    const SizedBox(width: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        state.status == DetailStatus.loading
                            ? text.loadingReviews
                            : text.reviewCount(
                                state.university?.reviews?.length ?? 0),
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    const Spacer(),
                    SortButton(
                      label: text.newFirst,
                      icon: AppImages.iCalendar,
                      onTap: () {
                        context.read<DetailUniversityCubit>().changeSort(SortType.date);
                      },
                      currentType: state.sortType ?? SortType.date,
                      type: SortType.date,
                    ),
                    const SizedBox(width: 10),
                    SortButton(
                      label: text.countLikeFirst,
                      icon: AppImages.iLike,
                      onTap: () {
                        context.read<DetailUniversityCubit>().changeSort(SortType.like);
                      },
                      currentType: state.sortType ?? SortType.date,
                      type: SortType.like,
                    ),
                  ],
                ),
              ),
              if ((state.university?.reviews ?? []).isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: (((index + 1) % 3) == 0) ? 75 : 0,
                      ),
                      child: BlocProvider(
                        create: (context) => getIt.get<ReviewItemCubit>(),
                        child: ReviewItem(
                          currentUser: state.userAuthenticated,
                          university: state.university ?? const University(-1),
                          review: (state.university?.reviews ?? [])[index],
                          onUpdateReviewIndex: (review) =>
                          state.university?.reviews?[index] = review,
                        ),
                      ),
                    );
                  },
                  itemCount: state.university?.reviews?.length ?? 0,
                  separatorBuilder: (_, __) => const SizedBox(height: 30),
                ),
              if ((state.university?.reviews ?? []).isEmpty)
                SizedBox(height: MediaQuery
                    .sizeOf(context)
                    .width * 0.5),
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

class SortButton extends StatelessWidget {
  final String label;
  final String icon;
  final Function onTap;
  final SortType type;
  final SortType currentType;

  const SortButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.type,
    required this.currentType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SelectionContainer.disabled(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
              type == currentType ? AppColors.level5 : Colors.transparent,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      type == currentType ? Colors.white : AppColors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                ResponsiveBuilder(
                  smallView: Container(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      label,
                      style: theme.primaryTextTheme.titleLarge?.copyWith(
                        color: type == currentType
                            ? Colors.white
                            : AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewItem extends StatefulWidget {
  final Review review;
  final Profile? currentUser;
  final University? university;
  final Function(Review) onUpdateReviewIndex;
  final bool? isPreview;

  const ReviewItem({
    super.key,
    this.currentUser,
    this.university,
    this.isPreview = false,
    required this.review,
    required this.onUpdateReviewIndex,
  });

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  Future<void> _onReport(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt.get<ReportCubit>(),
          child: ReportReviewForm(review: widget.review),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context
        .read<ReviewItemCubit>()
        .onInitReviewUI(widget.review, widget.currentUser);
  }

  @override
  void didUpdateWidget(covariant ReviewItem oldWidget) {
    context
        .read<ReviewItemCubit>()
        .onInitReviewUI(widget.review, widget.currentUser);
    super.didUpdateWidget(oldWidget);
  }

  void _likeReview(BuildContext context, Review review, int? userId) async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    if (!context.mounted) return;
    if (token == null || userId == null) {
      _showNoticeMustLoginDialog(context);
    } else {
      context.read<ReviewItemCubit>().upVoteReview(review, userId);
    }
  }

  void _dislikeReview(BuildContext context, Review review, int? userId) async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    if (!context.mounted) return;
    if (token == null || userId == null) {
      _showNoticeMustLoginDialog(context);
    } else {
      context.read<ReviewItemCubit>().downVoteReview(review, userId);
    }
  }

  void _showNoticeMustLoginDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const NoticeMustLoginDialog(about: NoticeAbout.vote);
      },
    );
  }

  void _openEditReviewForm(BuildContext context,
      Review review, {
        University? university,
      }) async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    if (!context.mounted) return;
    if (token == null) {
      _showNoticeMustLoginDialog(context);
    } else {
      context.goNamed(
        RouteKey.editReview,
        pathParameters: {
          "uniId": "${review.schoolId}",
          "reviewId": "${review.id}",
        },
        extra: EditReviewParam(university: university, review: review),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BlocListener<ReviewItemCubit, ReviewItemState>(
        listener: (context, state) {
          if (state.status == ReviewItemStatus.success) {
            if (state.review == null) return;
            widget.onUpdateReviewIndex(state.review!);
          }
          if (state.status == ReviewItemStatus.error) {
            appToast(
              context,
              message: AppLocalizations.of(context)!.somethingWrong,
              subMessage: AppLocalizations.of(context)!.tryAgainLater,
            );
          }
        },
        child: BlocBuilder<ReviewItemCubit, ReviewItemState>(
          builder: (context, state) {
            if (state.review == null) {
              return const SizedBox.shrink();
            }
            return Container(
              color: AppColors.primaryShadow,
              constraints: const BoxConstraints(maxWidth: Public.tabletSize),
              padding: const EdgeInsets.all(22).copyWith(bottom: 10),
              child: ResponsiveBuilder(
                mediumView: Column(
                  children: [
                    MyReview(
                      state: state,
                      onEditReview: () =>
                          _openEditReviewForm(
                            context,
                            widget.review,
                            university: widget.university,
                          ),
                      onGoToSchool: () => context.goNamed(
                        RouteKey.university,
                        pathParameters: {
                          "id": "${widget.review.schoolId}"
                        },
                      ),
                    ),
                    OverallPoint(review: state.review!),
                    const SizedBox(height: 15),
                    ReviewContent(
                      state: state,
                      isPreview: widget.isPreview ?? false,
                      onReport: () => _onReport(context),
                      onLike: (userId) =>
                          _likeReview(
                            context,
                            state.review!,
                            userId,
                          ),
                      onDislike: (userId) =>
                          _dislikeReview(
                            context,
                            state.review!,
                            userId,
                          ),
                      review: state.review!,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    MyReview(
                      state: state,
                      onEditReview: () =>
                          _openEditReviewForm(
                            context,
                            widget.review,
                            university: widget.university,
                          ),
                      onGoToSchool: () => context.goNamed(
                        RouteKey.university,
                        pathParameters: {
                          "id": "${widget.review.schoolId}"
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OverallPoint(review: state.review!),
                        const SizedBox(width: 35),
                        Expanded(
                          child: ReviewContent(
                            state: state,
                            isPreview: widget.isPreview ?? false,
                            onReport: () => _onReport(context),
                            onLike: (userId) =>
                                _likeReview(
                                  context,
                                  state.review!,
                                  userId,
                                ),
                            onDislike: (userId) =>
                                _dislikeReview(
                                  context,
                                  state.review!,
                                  userId,
                                ),
                            review: state.review!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyReview extends StatelessWidget {
  final ReviewItemState state;
  final Function onEditReview;
  final Function onGoToSchool;

  const MyReview({
    super.key,
    required this.state,
    required this.onEditReview,
    required this.onGoToSchool,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Visibility(
      visible: state.userAuthenticated?.id == state.review?.userId,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: PrimaryButton(
                  alignment: Alignment.centerLeft,
                  onTap: () => onGoToSchool(),
                  hasBorder: false,
                  title: state.review?.schoolName ?? '',
                  isOutline: true,
                  titleTextStyleColor: AppColors.black,
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(width: 4),
              SelectionContainer.disabled(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onEditReview(),
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
  const DashLine({
    Key? key,
    this.height = 1,
    this.color = Colors.grey,
  }) : super(key: key);

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
  final ReviewItemState state;
  final Function(int?) onLike;
  final Function(int?) onDislike;
  final bool isPreview;

  const ReviewContent({
    super.key,
    required this.onReport,
    required this.state,
    required this.review,
    required this.onLike,
    required this.onDislike,
    required this.isPreview,
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
        Visibility(
          visible: !isPreview,
          child: Row(
            children: [
              Tooltip(
                message: text.helpful,
                child: IconButton(
                  onPressed: () => onLike(state.userAuthenticated?.id),
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: BlocBuilder<ReviewItemCubit, ReviewItemState>(
                      builder: (context, state) {
                        if (state.status == ReviewItemStatus.loading &&
                            state.action == ReviewItemAction.like) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: PrimaryCircularLoading(
                              state.status == ReviewItemStatus.loading,
                              strokeWidth: 5,
                              strokeColor: AppColors.black,
                            ),
                          );
                        }
                        return (state.review?.liked?.userLiked ?? [])
                            .contains(state.userAuthenticated?.id ?? -1)
                            ? SvgPicture.asset(AppImages.iLiked)
                            : SvgPicture.asset(AppImages.iLike);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              SizedBox(
                width: 50,
                child: Text(
                  (review.liked?.userLiked?.length ?? 0).toString(),
                  style: theme.primaryTextTheme.labelLarge,
                ),
              ),
              const SizedBox(width: 10),
              Tooltip(
                message: text.notHelpful,
                child: IconButton(
                  onPressed: () => onDislike(state.userAuthenticated?.id),
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: BlocBuilder<ReviewItemCubit, ReviewItemState>(
                      builder: (context, state) {
                        if (state.status == ReviewItemStatus.loading &&
                            state.action == ReviewItemAction.dislike) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: PrimaryCircularLoading(
                              state.status == ReviewItemStatus.loading,
                              strokeWidth: 5,
                              strokeColor: AppColors.black,
                            ),
                          );
                        }
                        return (state.review?.liked?.userDisLiked ?? [])
                            .contains(state.userAuthenticated?.id ?? -1)
                            ? SvgPicture.asset(AppImages.iDisliked)
                            : SvgPicture.asset(AppImages.iDislike);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Text(
                (review.liked?.userDisLiked?.length ?? 0).toString(),
                style: theme.primaryTextTheme.labelLarge,
              ),
              const Spacer(),
              Visibility(
                visible: state.userAuthenticated?.id != state.review?.userId,
                child: Tooltip(
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
              ),
            ],
          ),
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
