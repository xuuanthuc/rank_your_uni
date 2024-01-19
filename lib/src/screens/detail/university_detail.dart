import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/detail/bloc/detail_cubit.dart';
import 'package:template/src/screens/detail/widgets/overall.dart';
import 'package:template/src/screens/detail/widgets/reviews.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';

class UniversityDetail extends StatelessWidget {
  final int id;
  final University? university;

  const UniversityDetail({super.key, required this.id, this.university});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DetailCubit>(),
      child: UniversityView(
        id: id,
        university: university,
      ),
    );
  }
}

class UniversityView extends StatefulWidget {
  final int id;
  final University? university;

  const UniversityView({
    super.key,
    required this.id,
    this.university,
  });

  @override
  State<UniversityView> createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  @override
  void initState() {
    super.initState();
    context.read<DetailCubit>().getDetailUniversity(
          widget.id,
          widget.university,
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DetailCubit, DetailState>(
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
                .read<DetailCubit>()
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
                  ReviewsBuilder(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
