import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/detail/bloc/detail_university_cubit.dart';
import 'package:template/src/screens/widgets/point_container.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../../global/storage/storage_keys.dart';
import '../../../../global/storage/storage_provider.dart';
import '../../../../global/style/styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/required_login_dialog.dart';

class UniversityOverview extends StatelessWidget {
  const UniversityOverview({super.key});

  void _openReviewForm(BuildContext context, University? university) async {
    if (university == null) return;
    final token = await StorageProvider.instance.get(StorageKeys.token);
    if (!context.mounted) return;
    if (token == null) {
      _showNoticeMustLoginDialog(context);
    } else {
      context.goNamed(
        RouteKey.reviewUniversity,
        pathParameters: {
          "id": "${university.id}",
        },
        extra: university,
      );
    }
  }

  void _compareUniversity(BuildContext context, University? university) {
    if (university == null) return;
    context.goNamed(
      RouteKey.compare,
      pathParameters: {"id": "${university.id}"},
      extra: university,
    );
  }

  void _showNoticeMustLoginDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const NoticeMustLoginDialog(about: NoticeAbout.private);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: BlocBuilder<DetailUniversityCubit, DetailUniversityState>(
        builder: (context, state) {
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveBuilder.setHorizontalPadding(context)),
              constraints: const BoxConstraints(
                maxWidth: Public.laptopSize,
              ),
              child: ResponsiveBuilder(
                smallView: Column(
                  children: [
                    const SizedBox(height: 40),
                    OverallPoint(university: state.university),
                    const SizedBox(height: 14),
                    UniversityName(university: state.university),
                    const SizedBox(height: 14),
                    UniversityAddress(university: state.university),
                    const SizedBox(height: 28),
                    ActionReviewAndCompare(
                      addReview: () =>
                          _openReviewForm(context, state.university),
                      compareUniversity: () =>
                          _compareUniversity(context, state.university),
                    ),
                    const SizedBox(height: 40),
                    ReviewCriteria(
                        university: state.university,
                        criteria: Criteria.reputation),
                    ReviewCriteria(
                        university: state.university,
                        criteria: Criteria.competition),
                    ReviewCriteria(
                        university: state.university,
                        criteria: Criteria.internet),
                    ReviewCriteria(
                        university: state.university,
                        criteria: Criteria.location),
                    ReviewCriteria(
                        university: state.university,
                        criteria: Criteria.favorite),
                    ReviewCriteria(
                        university: state.university,
                        criteria: Criteria.infrastructure),
                    ReviewCriteria(
                        university: state.university, criteria: Criteria.clubs),
                    ReviewCriteria(
                        university: state.university, criteria: Criteria.food),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OverallPoint(university: state.university),
                          const SizedBox(width: 25),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UniversityAddress(university: state.university),
                                const SizedBox(height: 14),
                                UniversityName(university: state.university),
                                const SizedBox(height: 28),
                                ActionReviewAndCompare(
                                  addReview: () => _openReviewForm(
                                      context, state.university),
                                  compareUniversity: () => _compareUniversity(
                                      context, state.university),
                                ),
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
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.reputation),
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.competition),
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.internet),
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.location),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: VerticalDivider(
                              color: AppColors.grey,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.favorite),
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.infrastructure),
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.clubs),
                                ReviewCriteria(
                                    university: state.university,
                                    criteria: Criteria.food),
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
          );
        },
      ),
    );
  }
}

class ActionReviewAndCompare extends StatelessWidget {
  final Function addReview;
  final Function compareUniversity;

  const ActionReviewAndCompare({
    super.key,
    required this.addReview,
    required this.compareUniversity,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return ResponsiveBuilder(
      smallView: Column(
        children: [
          PrimaryButton(
            onTap: () => addReview(),
            title: text.reviewThisUniversity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            onTap: () => compareUniversity(),
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
          PrimaryButton(
            onTap: () => addReview(),
            title: text.reviewThisUniversity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
          const SizedBox(width: 16),
          PrimaryButton(
            onTap: () => compareUniversity(),
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
  final University? university;

  const UniversityAddress({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          university?.address ?? '',
          style: theme.primaryTextTheme.bodyLarge,
        ),
      ],
    );
  }
}

class UniversityName extends StatelessWidget {
  final University? university;

  const UniversityName({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoSizeText(
      university?.name ?? '',
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
  final University? university;

  const OverallPoint({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: SizedBox(
        width: 220,
        height: 180,
        child: Stack(
          children: [
            SvgPicture.asset(
              AppImages.iPaint,
              colorFilter: ColorFilter.mode(
                getBackgroundPoint(university?.averagePointAllReviews ?? 0),
                BlendMode.srcIn,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${university?.averagePointAllReviews ?? 0}",
                style: const TextStyle(
                  fontFamily: "Angkor",
                  fontSize: 70,
                ),
              ),
            )
          ],
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

class ReviewCriteria extends StatelessWidget {
  final Criteria criteria;
  final University? university;

  const ReviewCriteria({
    super.key,
    required this.criteria,
    required this.university,
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
        PointContainer.small(
          point: getReviewPoint(university, criteria),
        )
      ],
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
}
