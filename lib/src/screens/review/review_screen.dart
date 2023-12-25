import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/review/bloc/review_cubit.dart';
import 'package:template/src/screens/review/widgets/item_rate.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';
import '../../global_bloc/authentication/authentication_bloc.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/loading_primary_button.dart';
import 'bloc/item_criteria_cubit.dart';
import 'widgets/review_text_area.dart';

class ReviewForm extends StatelessWidget {
  final String universityId;
  final University? university;

  const ReviewForm({
    super.key,
    required this.universityId,
    this.university,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ReviewCubit>(),
      child: ReviewView(
        universityId: universityId,
        university: university,
      ),
    );
  }
}

class ReviewView extends StatefulWidget {
  final String universityId;
  final University? university;

  const ReviewView({
    super.key,
    required this.universityId,
    this.university,
  });

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  void onSubmitReview(BuildContext context, int userId) {
    context
        .read<ReviewCubit>()
        .onSubmitReview(int.tryParse(widget.universityId) ?? -1, userId);
  }

  void updatePoint(BuildContext context, CriteriaRated rated) {
    context.read<ReviewCubit>().onUpdateReview(rated);
  }

  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getDetailUniversity(
          int.tryParse(widget.universityId) ?? -1,
          widget.university,
        );
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
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return LoadingPrimaryButton<ReviewCubit, ReviewState>(
                        onTap: () {
                          if (state.profileAuthenticated == null) return;
                          onSubmitReview(
                              context, state.profileAuthenticated!.id!);
                        },
                        label: text.submitReview,
                        buttonWidth: 250,
                        updateLoading: (state) {
                          return (state).status == ReviewStatus.loading;
                        },
                        updateColor: (state) {
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
                            return AppColors.grey;
                          } else {
                            return null;
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
