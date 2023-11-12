import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/src/screens/review/widgets/item_rate.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/style/styles.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/button_common.dart';
import 'widgets/review_text_area.dart';

class ReviewForm extends StatelessWidget {
  final String universityId;

  const ReviewForm({
    super.key,
    required this.universityId,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      children: [
        Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: Public.laptopSize,
            ),
            padding: EdgeInsets.all(
              ResponsiveBuilder.setHorizontalPadding(context),
            ),
            child: Column(
              children: [
                AutoSizeText(
                  text.reviewUniversity(
                      'Trường Đại học Khoa học Xã hội và Nhân văn - Đại học Quốc gia Thành Phố Hồ Chí Minh'),
                  style: theme.primaryTextTheme.displayLarge,
                  maxLines: 3,
                  minFontSize: 12,
                ),
                const SizedBox(height: 30),
                const CriteriaReviewLevel(criteria: Criteria.reputation),
                const CriteriaReviewLevel(criteria: Criteria.competition),
                const CriteriaReviewLevel(criteria: Criteria.internet),
                const CriteriaReviewLevel(criteria: Criteria.location),
                const CriteriaReviewLevel(criteria: Criteria.favorite),
                const CriteriaReviewLevel(criteria: Criteria.infrastructure),
                const CriteriaReviewLevel(criteria: Criteria.clubs),
                const CriteriaReviewLevel(criteria: Criteria.food),
                const ReviewArea(),
                const SizedBox(height: 45),
                SizedBox(
                  width: 250,
                  child: AppButton(
                    onTap: () {},
                    title: text.submitReview,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
