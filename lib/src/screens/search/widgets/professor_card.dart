import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/professor.dart';
import '../../widgets/point_container.dart';

class ProfessorCard extends StatelessWidget {
  final Function onTap;
  final Professor professor;

  const ProfessorCard({
    super.key,
    required this.onTap,
    required this.professor,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SelectionContainer.disabled(
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 25 / 2,
            ),
            padding: const EdgeInsets.all(20),
            color: AppColors.primaryShadow,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingQuality(professor),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ProfessorName(professor: professor),
                        const SizedBox(height: 12),
                        ProfessorUniversity(professor: professor),
                        ProfessorMoreInfomation(professor: professor),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingQuality extends StatelessWidget {
  final Professor professor;

  const RatingQuality(this.professor, {super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text.quality,
          style: theme.primaryTextTheme.labelLarge?.copyWith(
            fontSize: 13,
          ),
        ),
        PointContainer.regular(point: professor.averagePointAllReviews ?? 0.0),
        Text(
          text.reviewCount(0),
          style: theme.primaryTextTheme.bodyMedium?.copyWith(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class ProfessorName extends StatelessWidget {
  final Professor professor;

  const ProfessorName({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      professor.fullName ?? '',
      style: theme.primaryTextTheme.displayMedium
          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
      maxLines: 2,
    );
  }
}

class ProfessorUniversity extends StatelessWidget {
  final Professor professor;

  const ProfessorUniversity({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    return Text(
      professor.universityName ??
          AppLocalizations.of(context)!.notFoundInformation,
      maxLines: 2,
    );
  }
}

class ProfessorMoreInfomation extends StatelessWidget {
  final Professor professor;

  const ProfessorMoreInfomation({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    return Text(
      professor.universityName ??
          AppLocalizations.of(context)!.notFoundInformation,
      maxLines: 2,
    );
  }
}
