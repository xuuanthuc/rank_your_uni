import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:template/global/utilities/extensions.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../../global/style/app_colors.dart';
import '../../../../global/style/app_images.dart';
import '../../../../global/utilities/public.dart';
import '../bloc/detail_professor_cubit.dart';

class ProfessorOverall extends StatelessWidget {
  const ProfessorOverall({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: ResponsiveBuilder.setHorizontalPadding(context)),
        constraints: const BoxConstraints(
          maxWidth: Public.laptopSize,
        ),
        padding: const EdgeInsets.only(top: 40),
        child: const ResponsiveBuilder(
          mediumView: Column(
            children: [ProfessorInfomation(), ProfessorAveragePoint()],
          ),
          child: Row(
            children: [
              Expanded(child: ProfessorInfomation()),
              Expanded(child: ProfessorAveragePoint()),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfessorInfomation extends StatelessWidget {
  const ProfessorInfomation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProfessorCubit, DetailProfessorState>(
      builder: (context, state) {
        return Column(
          children: [
            OverallPoint(professor: state.professor),
            const SizedBox(height: 28),
            ProfessorName(professor: state.professor),
            const SizedBox(height: 14),
            ProfessorUniversity(professor: state.professor),
            const SizedBox(height: 28),
            ProfessorMoreInfomation(
              professor: state.professor,
            )
          ],
        );
      },
    );
  }
}

class ProfessorAveragePoint extends StatelessWidget {
  const ProfessorAveragePoint({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProfessorCubit, DetailProfessorState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}

class OverallPoint extends StatelessWidget {
  final Professor? professor;

  const OverallPoint({super.key, required this.professor});

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
                getBackgroundPoint(professor?.averagePointAllReviews ?? 0),
                BlendMode.srcIn,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${professor?.averagePointAllReviews ?? 0}",
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

class ProfessorName extends StatelessWidget {
  final Professor? professor;

  const ProfessorName({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoSizeText(
      professor?.fullName ?? '',
      style: theme.primaryTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 30,
      ),
      minFontSize: 20,
      maxLines: 3,
    );
  }
}

class ProfessorUniversity extends StatelessWidget {
  final Professor? professor;

  const ProfessorUniversity({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Text(
      text.professorAt(
          professor?.major?.name ?? "", professor?.university?.name ?? ''),
      style: theme.primaryTextTheme.bodyMedium?.copyWith(fontSize: 16),
    );
  }
}

class ProfessorMoreInfomation extends StatelessWidget {
  final Professor? professor;

  const ProfessorMoreInfomation({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                professor?.reLearnRate != null
                    ? "${professor?.reLearnRate}%"
                    : text.na,
                style: const TextStyle(
                  fontFamily: "Angkor",
                  fontSize: 28,
                ),
              ),
              Text(
                text.wouldTakeAgain.trim(),
                style: theme.primaryTextTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 60,
          color: Colors.black,
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                (professor?.hardAvg ?? 0.0).toString(),
                style: const TextStyle(
                  fontFamily: "Angkor",
                  fontSize: 28,
                ),
              ),
              Text(
                text.levelOfDifficulty.trim(),
                style: theme.primaryTextTheme.bodyMedium,
              ),
            ],
          ),
        )
      ],
    );
  }
}
