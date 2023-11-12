import 'package:auto_size_text/auto_size_text.dart';
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
        child: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => onTap(),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width > Public.laptopSize
                    ? Public.tabletSize
                    : Public.laptopSize,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 25 / 2,
                horizontal: ResponsiveBuilder.setHorizontalPadding(context),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: AppColors.primaryShadow,
              child: ResponsiveBuilder(
                tinyView: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const RatingQuality(),
                        UniversityAddress(university: university),
                      ],
                    ),
                    const SizedBox(height: 7),
                    UniversityName(university: university),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RatingQuality(),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UniversityAddress(university: university),
                          const SizedBox(height: 12),
                          UniversityName(university: university),

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
  const RatingQuality({super.key});

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
            fontSize: 14,
          ),
        ),
        const PointContainer.regular(),
        Text(text.reviewCount(50)),
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
    return AutoSizeText(
      university.name ?? '',
      style: theme.primaryTextTheme.displayMedium
          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
      maxLines: 3,
      minFontSize: 14,
    );
  }
}

class UniversityAddress extends StatelessWidget {
  final University university;
  const UniversityAddress({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AutoSizeText(
          university.address ?? '',
          maxLines: 1,
          minFontSize: 10,
        ),
      ],
    );
  }
}
