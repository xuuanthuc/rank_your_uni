import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../global/style/styles.dart';
import '../../widgets/button_common.dart';

class ReviewArea extends StatelessWidget {
  const ReviewArea({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25 / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: theme.primaryColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text.writeReview,
              style: theme.primaryTextTheme.labelLarge,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    text.tooltipWriteReview,
                    style: theme.primaryTextTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.level4.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.iProtect),
                              const SizedBox(width: 4),
                              Text(
                                text.guideline,
                                style: theme.primaryTextTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(text.guidelineBasic1),
                          const SizedBox(height: 8),
                          Text(text.guidelineBasic2),
                          const SizedBox(height: 8),
                          Text(text.guidelineBasic3),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              AppButton(
                                onTap: () {},
                                hasBorder: false,
                                title: text.seeAllGuideline,
                                isOutline: true,
                                titleTextStyleColor: AppColors.black,
                                fontSize: 13,
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
