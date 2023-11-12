import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../widgets/point_container.dart';

class UniversityCard extends StatelessWidget {
  final Function onTap;

  const UniversityCard({
    super.key,
    required this.onTap,
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
              child: const ResponsiveBuilder(
                tinyView: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingQuality(),
                        UniversityAddress(),
                      ],
                    ),
                    SizedBox(height: 7),
                    UniversityName(),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingQuality(),
                    SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UniversityAddress(),
                          SizedBox(height: 12),
                          UniversityName(),

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
  const UniversityName({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoSizeText(
      'Trường Đại học Khoa học Xã hội và Nhân văn - Đại học Quốc gia Thành Phố Hồ Chí Minh',
      style: theme.primaryTextTheme.displayMedium
          ?.copyWith(fontWeight: FontWeight.w800, fontSize: 20),
      maxLines: 3,
      minFontSize: 14,
    );
  }
}

class UniversityAddress extends StatelessWidget {
  const UniversityAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AutoSizeText(
          "Cầu Giấy, Hà Nội",
          maxLines: 1,
          minFontSize: 10,
        ),
      ],
    );
  }
}
