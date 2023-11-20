import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/review/bloc/review_cubit.dart';
import 'package:template/src/screens/review/widgets/item_rate.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/button_common.dart';
import 'bloc/item_criteria_cubit.dart';
import 'widgets/review_text_area.dart';

class ReviewForm extends StatelessWidget {
  final String universityId;

  const ReviewForm({
    super.key,
    required this.universityId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ReviewCubit>(),
      child: ReviewView(universityId: universityId),
    );
  }
}

class ReviewView extends StatefulWidget {
  final String universityId;

  const ReviewView({
    super.key,
    required this.universityId,
  });

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  void onSubmitReview(BuildContext context) {
    context
        .read<ReviewCubit>()
        .onSubmitReview(int.tryParse(widget.universityId) ?? 0);
  }

  void updatePoint(BuildContext context, CriteriaRated rated) {
    context.read<ReviewCubit>().onUpdateReview(rated);
  }

  @override
  void initState() {
    super.initState();
    context
        .read<ReviewCubit>()
        .getDetailUniversity(int.tryParse(widget.universityId) ?? 0);
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
        }
      },
      child: AppScaffold(
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: Public.laptopSize,
              ),
              padding: EdgeInsets.all(
                ResponsiveBuilder.setHorizontalPadding(context),
              ),
              child: Column(
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
                    criteria: Criteria.reputation,
                  ),
                  CriteriaReviewLevel(
                    onUpdate: (rate) => updatePoint(context, rate),
                    criteria: Criteria.competition,
                  ),
                  CriteriaReviewLevel(
                    onUpdate: (rate) => updatePoint(context, rate),
                    criteria: Criteria.internet,
                  ),
                  CriteriaReviewLevel(
                    onUpdate: (rate) => updatePoint(context, rate),
                    criteria: Criteria.location,
                  ),
                  CriteriaReviewLevel(
                    onUpdate: (rate) => updatePoint(context, rate),
                    criteria: Criteria.favorite,
                  ),
                  CriteriaReviewLevel(
                    onUpdate: (rate) => updatePoint(context, rate),
                    criteria: Criteria.infrastructure,
                  ),
                  CriteriaReviewLevel(
                    onUpdate: (rate) => updatePoint(context, rate),
                    criteria: Criteria.clubs,
                  ),
                  CriteriaReviewLevel(
                    onUpdate: (rate) => updatePoint(context, rate),
                    criteria: Criteria.food,
                  ),
                  const ReviewArea(),
                  const SizedBox(height: 45),
                  SizedBox(
                      width: 250,
                      child: BlocBuilder<ReviewCubit, ReviewState>(
                        builder: (context, state) {
                          Color? backgroundColor;
                          if (state.internet == null ||
                              state.location == null ||
                              state.status == ReviewStatus.loading ||
                              state.reputation == null ||
                              state.favorite == null ||
                              state.food == null ||
                              state.facilities == null ||
                              state.competition == null ||
                              (state.contentRated ?? "").trim().isEmpty ||
                              state.clubs == null) {
                            backgroundColor = AppColors.grey;
                          } else {
                            backgroundColor = null;
                          }
                          return AppButton(
                            onTap: state.status == ReviewStatus.loading
                                ? () {}
                                : () => onSubmitReview(context),
                            title: text.submitReview,
                            height: 56,
                            backgroundColor: backgroundColor,
                            borderColor: backgroundColor,
                            child: state.status == ReviewStatus.loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          );
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
