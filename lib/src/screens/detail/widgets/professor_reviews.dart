import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/models/request/edit_review_param.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/professor_review.dart';
import 'package:template/src/screens/detail/bloc/professor_review_item_cubit.dart';
import 'package:template/src/screens/detail/widgets/university_reviews.dart';
import '../../../../global/enum/review_sort_type.dart';
import '../../../../global/routes/route_keys.dart';
import '../../../../global/storage/storage_keys.dart';
import '../../../../global/storage/storage_provider.dart';
import '../../../../global/style/styles.dart';
import '../../../../global/utilities/format.dart';
import '../../../../global/utilities/toast.dart';
import '../../../di/dependencies.dart';
import '../../../models/response/profile.dart';
import '../../widgets/loading.dart';
import '../../widgets/point_container.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/required_login_dialog.dart';
import '../../widgets/responsive_builder.dart';
import '../bloc/detail_professor_cubit.dart';
import '../bloc/report_cubit.dart';
import '../report_review_form.dart';

class ProfessorReviewsBuilder extends StatelessWidget {
  const ProfessorReviewsBuilder({super.key});

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
      child: BlocBuilder<DetailProfessorCubit, DetailProfessorState>(
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
                                state.professor?.reviews?.length ?? 0),
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    const Spacer(),
                    SortButton(
                      label: text.newFirst,
                      icon: AppImages.iCalendar,
                      onTap: () {
                        context
                            .read<DetailProfessorCubit>()
                            .changeSort(SortType.date);
                      },
                      currentType: state.sortType ?? SortType.date,
                      type: SortType.date,
                    ),
                    const SizedBox(width: 10),
                    SortButton(
                      label: text.countLikeFirst,
                      icon: AppImages.iLike,
                      onTap: () {
                        context
                            .read<DetailProfessorCubit>()
                            .changeSort(SortType.like);
                      },
                      currentType: state.sortType ?? SortType.date,
                      type: SortType.like,
                    ),
                  ],
                ),
              ),
              if ((state.professor?.reviews ?? []).isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: (((index + 1) % 3) == 0) ? 75 : 0,
                      ),
                      child: BlocProvider(
                        create: (context) =>
                            getIt.get<ProfessorReviewItemCubit>(),
                        child: ReviewItem(
                          currentUser: state.userAuthenticated,
                          professor: state.professor ?? const Professor(-1),
                          review: (state.professor?.reviews ?? [])[index],
                          onUpdateReviewIndex: (review) =>
                              state.professor?.reviews?[index] = review,
                        ),
                      ),
                    );
                  },
                  itemCount: state.professor?.reviews?.length ?? 0,
                  separatorBuilder: (_, __) => const SizedBox(height: 30),
                ),
              if ((state.professor?.reviews ?? []).isEmpty)
                SizedBox(height: MediaQuery.sizeOf(context).width * 0.5),
              const SizedBox(height: 75),
            ],
          );
        },
      ),
    );
  }
}

class ReviewItem extends StatefulWidget {
  final ProfessorReview review;
  final Profile? currentUser;
  final Professor? professor;
  final Function(ProfessorReview) onUpdateReviewIndex;
  final bool? isDashboardPreview;

  const ReviewItem({
    super.key,
    this.currentUser,
    this.professor,
    this.isDashboardPreview = false,
    required this.review,
    required this.onUpdateReviewIndex,
  });

  @override
  State<ReviewItem> createState() => _ProfessorReviewItemState();
}

class _ProfessorReviewItemState extends State<ReviewItem> {
  Future<void> _onReport(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt.get<ReportCubit>(),
          child: ReportReviewForm(professorReview: widget.review),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context
        .read<ProfessorReviewItemCubit>()
        .onInitReviewUI(widget.review, widget.currentUser);
  }

  @override
  void didUpdateWidget(covariant ReviewItem oldWidget) {
    context
        .read<ProfessorReviewItemCubit>()
        .onInitReviewUI(widget.review, widget.currentUser);
    super.didUpdateWidget(oldWidget);
  }

  void _likeReview(
      BuildContext context, ProfessorReview review, int? userId) async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    if (!context.mounted) return;
    if (token == null || userId == null) {
      _showNoticeMustLoginDialog(context);
    } else {
      context.read<ProfessorReviewItemCubit>().upVoteReview(review, userId);
    }
  }

  void _dislikeReview(
      BuildContext context, ProfessorReview review, int? userId) async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    if (!context.mounted) return;
    if (token == null || userId == null) {
      _showNoticeMustLoginDialog(context);
    } else {
      context.read<ProfessorReviewItemCubit>().downVoteReview(review, userId);
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

  void _openEditReviewForm(
    BuildContext context,
    ProfessorReview review, {
    Professor? professor,
  }) async {
    final token = await StorageProvider.instance.get(StorageKeys.token);
    if (!context.mounted) return;
    if (token == null) {
      _showNoticeMustLoginDialog(context);
    } else {
      context.goNamed(
        RouteKey.editProfessorReview,
        pathParameters: {
          "professorId": "${review.teacherId}",
          "reviewId": "${review.id}",
        },
        extra: EditProfessorReviewParam(professor: professor, review: review),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BlocListener<ProfessorReviewItemCubit, ProfessorReviewItemState>(
        listener: (context, state) {
          if (state.status == ProfessorReviewItemStatus.success) {
            if (state.review == null) return;
            widget.onUpdateReviewIndex(state.review!);
          }
          if (state.status == ProfessorReviewItemStatus.error) {
            appToast(
              context,
              message: AppLocalizations.of(context)!.somethingWrong,
              subMessage: AppLocalizations.of(context)!.tryAgainLater,
            );
          }
        },
        child: BlocBuilder<ProfessorReviewItemCubit, ProfessorReviewItemState>(
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
                      onEditReview: () => _openEditReviewForm(
                        context,
                        widget.review,
                        professor: widget.professor,
                      ),
                      onGoToProfessor: () => context.goNamed(
                        RouteKey.professor,
                        pathParameters: {"id": "${widget.review.teacherId}"},
                      ),
                    ),
                    OverallPoint(review: state.review!),
                    const SizedBox(height: 15),
                    ReviewContent(
                      state: state,
                      isDashboardPreview: widget.isDashboardPreview ?? false,
                      onReport: () => _onReport(context),
                      onLike: (userId) => _likeReview(
                        context,
                        state.review!,
                        userId,
                      ),
                      onDislike: (userId) => _dislikeReview(
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
                      onEditReview: () => _openEditReviewForm(
                        context,
                        widget.review,
                        professor: widget.professor,
                      ),
                      onGoToProfessor: () => context.goNamed(
                        RouteKey.professor,
                        pathParameters: {"id": "${widget.review.teacherId}"},
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
                            isDashboardPreview:
                                widget.isDashboardPreview ?? false,
                            onReport: () => _onReport(context),
                            onLike: (userId) => _likeReview(
                              context,
                              state.review!,
                              userId,
                            ),
                            onDislike: (userId) => _dislikeReview(
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
  final ProfessorReviewItemState state;
  final Function onEditReview;
  final Function onGoToProfessor;

  const MyReview({
    super.key,
    required this.state,
    required this.onEditReview,
    required this.onGoToProfessor,
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
                  onTap: () => onGoToProfessor(),
                  hasBorder: false,
                  title: state.review?.teacherName ?? '',
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
  final ProfessorReview review;
  final Function onReport;
  final ProfessorReviewItemState state;
  final Function(int?) onLike;
  final Function(int?) onDislike;
  final bool isDashboardPreview;

  const ReviewContent({
    super.key,
    required this.onReport,
    required this.state,
    required this.review,
    required this.onLike,
    required this.onDislike,
    required this.isDashboardPreview,
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
        Visibility(
          visible: !isDashboardPreview,
          child: Row(
            children: [
              Tooltip(
                message: text.helpful,
                child: IconButton(
                  onPressed: () => onLike(state.userAuthenticated?.id),
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: BlocBuilder<ProfessorReviewItemCubit,
                        ProfessorReviewItemState>(
                      builder: (context, state) {
                        if (state.status == ProfessorReviewItemStatus.loading &&
                            state.action == ProfessorReviewItemAction.like) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: PrimaryCircularLoading(
                              state.status == ProfessorReviewItemStatus.loading,
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
                    child: BlocBuilder<ProfessorReviewItemCubit,
                        ProfessorReviewItemState>(
                      builder: (context, state) {
                        if (state.status == ProfessorReviewItemStatus.loading &&
                            state.action == ProfessorReviewItemAction.dislike) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: PrimaryCircularLoading(
                              state.status == ProfessorReviewItemStatus.loading,
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
  final ProfessorReview review;

  const ReviewDescription({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          review.courseName ?? '',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Visibility(
              visible: review.hardAttendance != null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  children: [
                    Text(
                      text.hardAttendance,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      review.hardAttendance == true ? text.yes : text.no,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 30)
                  ],
                ),
              ),
            ),
            Visibility(
              visible:
                  (review.point ?? "").isNotEmpty && review.point != "Trống",
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  children: [
                    Text(
                      text.point,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      review.point ?? '',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 30)
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          constraints: const BoxConstraints(minHeight: 80),
          child: Text(
            review.contentRate ?? '',
            style: theme.primaryTextTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            (review.tags ?? []).length,
            (index) {
              final tag = (review.tags ?? [])[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.primary,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  tag.label ?? '',
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 12
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ReviewDate extends StatelessWidget {
  final ProfessorReview review;

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
  final ProfessorReview review;

  const OverallPoint({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return ResponsiveBuilder(
      mediumView: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text.quality,
                style: theme.primaryTextTheme.bodyLarge,
              ),
              ResponsiveBuilder(
                tinyView: PointContainer.small(
                  point: review.averagePointPerReview ?? 0,
                ),
                child: PointContainer.medium(
                  point: review.averagePointPerReview ?? 0,
                ),
              ),
            ],
          ),
          const SizedBox(width: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text.hardLevel,
                style: theme.primaryTextTheme.bodyLarge,
              ),
              ResponsiveBuilder(
                tinyView: PointContainer.small(
                  point: (review.hard ?? 0).toDouble(),
                  hasColor: false,
                ),
                child: PointContainer.medium(
                  point: (review.hard ?? 0).toDouble(),
                  hasColor: false,
                ),
              ),
            ],
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text.quality,
            style: theme.primaryTextTheme.bodyLarge,
          ),
          ResponsiveBuilder(
            tinyView: PointContainer.small(
              point: review.averagePointPerReview ?? 0,
            ),
            child: PointContainer.medium(
              point: review.averagePointPerReview ?? 0,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            text.hardLevel,
            style: theme.primaryTextTheme.bodyLarge,
          ),
          ResponsiveBuilder(
            tinyView: PointContainer.small(
              point: (review.hard ?? 0).toDouble(),
              hasColor: false,
            ),
            child: PointContainer.medium(
              point: (review.hard ?? 0).toDouble(),
              hasColor: false,
            ),
          ),
        ],
      ),
    );
  }
}
