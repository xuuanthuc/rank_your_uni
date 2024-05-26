import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/screens/detail/bloc/detail_professor_cubit.dart';
import 'package:template/src/screens/detail/widgets/professor_overall.dart';
import 'package:template/src/screens/detail/widgets/professor_reviews.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';

class ProfessorDetail extends StatefulWidget {
  final int id;
  final Professor? professor;

  const ProfessorDetail({super.key, required this.id, this.professor});

  @override
  State<ProfessorDetail> createState() => _ProfessorDetailState();
}

class _ProfessorDetailState extends State<ProfessorDetail> {
  @override
  void initState() {
    super.initState();
    context.read<DetailProfessorCubit>().getDetailProfessor(
          widget.id,
          widget.professor,
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DetailProfessorCubit, DetailProfessorState>(
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
                .read<DetailProfessorCubit>()
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
                  ProfessorOverall(),
                  ProfessorReviewsBuilder(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
