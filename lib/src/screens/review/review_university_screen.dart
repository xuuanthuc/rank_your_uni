import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/models/response/university_review.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/review/bloc/review_cubit.dart';
import 'package:template/src/screens/review/widgets/item_rate.dart';
import 'package:template/src/screens/widgets/primary_dialog.dart';
import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';
import '../../models/response/profile.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/loading_primary_button.dart';
import '../widgets/required_login_dialog.dart';
import 'bloc/item_criteria_cubit.dart';
import 'widgets/review_text_area.dart';

class ReviewUniversityScreen extends StatefulWidget {
  final String universityId;
  final University? university;
  final UniversityReview? review;

  const ReviewUniversityScreen({
    super.key,
    required this.universityId,
    this.university,
    this.review,
  });

  @override
  State<ReviewUniversityScreen> createState() => _ReviewUniversityScreenState();
}

class _ReviewUniversityScreenState extends State<ReviewUniversityScreen> {
  final TextEditingController _reviewContentController =
      TextEditingController();

  void _showNoticeMustLoginDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const NoticeMustLoginDialog(about: NoticeAbout.private);
      },
    );
  }

  void onSubmitReview(BuildContext context, Profile? user) {
    if (user == null) {
      _showNoticeMustLoginDialog(context);
      return;
    }

    context.read<ReviewCubit>().onSubmitUniversityReview(
          int.tryParse(widget.universityId) ?? -1,
          user.id!,
          review: widget.review,
        );
  }

  void onDeleteReview(BuildContext context, Profile? user) async {
    if (user == null) {
      _showNoticeMustLoginDialog(context);
      return;
    }
    if (widget.review == null) return;
    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return PrimaryConfirmDialog(
          description: AppLocalizations.of(context)!.confirmDeleteReview,
          title: AppLocalizations.of(context)!.deleteReview,
        );
      },
    );
    if(result ?? false){
      if (!context.mounted) return;
      context.read<ReviewCubit>().onDeleteUniversityReview(widget.review!.id);
    }
  }

  void updatePoint(BuildContext context, CriteriaRated rated) {
    context.read<ReviewCubit>().onUpdateReview(rated);
  }

  @override
  void initState() {
    super.initState();
    _reviewContentController.text = widget.review?.content ?? '';
    context.read<ReviewCubit>().getDetailUniversity(
          int.tryParse(widget.universityId) ?? -1,
          widget.university,
          widget.review,
        );
  }

  @override
  void dispose() {
    _reviewContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state.status == ReviewStatus.error) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: AppLocalizations.of(context)!.tryAgainLater,
          );
        } else if (state.status == ReviewStatus.success) {
          context.goNamed(RouteKey.reviewSuccess, extra: state.university);
        } else if (state.status == ReviewStatus.deleteSuccess) {
          context.goNamed(RouteKey.deteleSuccess, extra: state.university);
        }
        // if (state.mode == ReviewMode.edit) {
        //   context.read<ReviewCubit>().initEditReviewMode(widget.review!);
        //   _reviewContentController.text = widget.review?.content ?? '';
        // }
      },
      child: AppScaffold(
        children: [
          BlocBuilder<ReviewCubit, ReviewState>(
            buildWhen: (_, cur) => cur.university != null,
            builder: (context, state) {
              return AutoSizeText(
                text.reviewUniversity(state.university?.name ?? ""),
                style: theme.primaryTextTheme.displayLarge,
                maxLines: 3,
                minFontSize: 12,
              );
            },
          ),
          const SizedBox(height: 30),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue: int.tryParse(
                widget.review?.reputation.toString() ?? ''),
            criteria: Criteria.reputation,
          ),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue: int.tryParse(
                widget.review?.competition.toString() ?? ''),
            criteria: Criteria.competition,
          ),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue:
            int.tryParse(widget.review?.internet.toString() ?? ''),
            criteria: Criteria.internet,
          ),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue:
            int.tryParse(widget.review?.location.toString() ?? ''),
            criteria: Criteria.location,
          ),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue:
            int.tryParse(widget.review?.favourite.toString() ?? ''),
            criteria: Criteria.favorite,
          ),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue: int.tryParse(
                widget.review?.facilities.toString() ?? ''),
            criteria: Criteria.infrastructure,
          ),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue:
            int.tryParse(widget.review?.clubs.toString() ?? ''),
            criteria: Criteria.clubs,
          ),
          CriteriaReviewLevel(
            onUpdate: (rate) => updatePoint(context, rate),
            initialValue:
            int.tryParse(widget.review?.food.toString() ?? ''),
            criteria: Criteria.food,
          ),
          ReviewArea(
            controller: _reviewContentController,
            type: AreaType.university,
          ),
          const SizedBox(height: 45),
          BlocBuilder<AppSettingsBloc, AppSettingsState>(
            builder: (context, setting) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Visibility(
                      visible: widget.review?.id == null,
                      child: Container(
                        constraints:
                        const BoxConstraints(maxWidth: 250),
                        child: LoadingPrimaryButton<ReviewCubit,
                            ReviewState>(
                          onTap: () {
                            onSubmitReview(
                              context,
                              setting.profileAuthenticated,
                            );
                          },
                          label: text.submitReview,
                          updateLoading: (state) {
                            return state.status ==
                                ReviewStatus.loading &&
                                state.action == ReviewAction.update;
                          },
                          updateColor: (state) {
                            if (state.internet == null ||
                                state.location == null ||
                                (state.status == ReviewStatus.loading &&
                                    state.action ==
                                        ReviewAction.update) ||
                                state.reputation == null ||
                                state.favorite == null ||
                                state.food == null ||
                                state.facilities == null ||
                                state.competition == null ||
                                (state.contentRated ?? "")
                                    .trim()
                                    .isEmpty ||
                                state.clubs == null) {
                              return AppColors.grey;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Visibility(
                      visible: widget.review?.id != null,
                      child: Container(
                        constraints:
                        const BoxConstraints(maxWidth: 250),
                        child: LoadingPrimaryButton<ReviewCubit,
                            ReviewState>(
                          onTap: () {
                            onDeleteReview(
                              context,
                              setting.profileAuthenticated,
                            );
                          },
                          label: text.deleteReview,
                          updateLoading: (state) {
                            return state.status ==
                                ReviewStatus.loading &&
                                state.action == ReviewAction.delete;
                          },
                          updateColor: (state) {
                            if (state.status == ReviewStatus.loading &&
                                state.action == ReviewAction.delete) {
                              return AppColors.grey;
                            } else {
                              return AppColors.error;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
