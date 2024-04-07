import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../widgets/point_container.dart';

class UniversityCard extends StatelessWidget {
  final Function onTap;
  final University university;

  const UniversityCard({
    super.key,
    required this.onTap,
    required this.university,
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
                      RatingQuality(university),
                    ],
                  ),
                  const SizedBox(height: 7),
                  UniversityName(university: university),
                  const SizedBox(height: 7),
                  UniversityAddress(university: university),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingQuality(university),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              UniversityAddress(university: university),
                            ],
                          ),
                          UniversityName(university: university),
                          Opacity(
                            opacity: 0,
                            child: UniversityAddress(university: university),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingQuality extends StatelessWidget {
  final University university;

  const RatingQuality(this.university, {super.key});

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
        PointContainer.regular(point: university.averagePointAllReviews ?? 0),
        Text(
          text.reviewCount(university.totalReviews ?? 0),
          style: theme.primaryTextTheme.bodyMedium?.copyWith(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class UniversityName extends StatelessWidget {
  final University university;

  const UniversityName({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      university.name ?? '',
      style: theme.primaryTextTheme.displayMedium
          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
      maxLines: 3,
    );
  }
}

class UniversityAddress extends StatelessWidget {
  final University university;

  const UniversityAddress({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return Text(
      university.address ?? '',
      maxLines: 1,
    );
  }
}
