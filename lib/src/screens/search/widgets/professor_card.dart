import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: AppColors.primaryShadow,
            child: ResponsiveBuilder(
              tinyView: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingQuality(professor),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ProfessorName(professor: professor),
                  const SizedBox(height: 7),
                  ProfessorUniversity(professor: professor),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingQuality(professor),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ProfessorUniversity(professor: professor),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ProfessorName(professor: professor),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          text.quality,
          style: theme.primaryTextTheme.labelLarge?.copyWith(
            fontSize: 13,
          ),
        ),
        PointContainer.regular(point: 0),
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
    return AutoSizeText(
      professor.fullName ?? '',
      style: theme.primaryTextTheme.displayMedium
          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
      maxLines: 3,
      minFontSize: 14,
    );
  }
}

class ProfessorUniversity extends StatelessWidget {
  final Professor professor;

  const ProfessorUniversity({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      professor.universityId.toString() ?? '',
      maxLines: 1,
      minFontSize: 10,
    );
  }
}
