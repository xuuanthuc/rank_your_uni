import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/detail/bloc/detail_university_cubit.dart';
import 'package:template/src/screens/detail/widgets/university_overall.dart';
import 'package:template/src/screens/detail/widgets/university_reviews.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';

class UniversityDetail extends StatefulWidget {
  final int id;
  final University? university;

  const UniversityDetail({super.key, required this.id, this.university});

  @override
  State<UniversityDetail> createState() => _UniversityDetailState();
}

class _UniversityDetailState extends State<UniversityDetail> {
  @override
  void initState() {
    super.initState();
    context.read<DetailUniversityCubit>().getDetailUniversity(
          widget.id,
          widget.university,
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DetailUniversityCubit, DetailUniversityState>(
          listenWhen: (_, cur) => cur.status == DetailStatus.error,
          listener: (context, state) {
            appToast(
              context,
              message: AppLocalizations.of(context)!.somethingWrong,
              subMessage: AppLocalizations.of(context)!.tryAgainLater,
            );
          },
        ),
        BlocListener<AppSettingsBloc, AppSettingsState>(
          listenWhen: (prev, curr) =>
              curr.action == AppSettingAction.updateProfile,
          listener: (context, state) {
            context
                .read<DetailUniversityCubit>()
                .updateCurrentUser(state.profileAuthenticated);
          },
        ),
      ],
      child: AppScaffold(
        maxWidth: MediaQuery.sizeOf(context).width,
        maxContentWidth: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              Image.asset(AppImages.iDetailBackground),
              const Column(
                children: [
                  UniversityOverview(),
                  UniversityReviewsBuilder(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
