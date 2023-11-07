import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/enum/rating_point.dart';
import 'package:template/src/screens/appbar/appbar_common.dart';
import 'package:template/src/screens/review/widgets/item_rate.dart';
import 'package:template/src/screens/widgets/footer_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../global/style/styles.dart';
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
    return Scaffold(
      appBar: AppbarCommon(
        onSearch: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(
                      text.reviewUniversity('Đại học bách khoa Hà Nội'),
                      style: theme.primaryTextTheme.displayLarge,
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
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ),
            const FooterCommon(),
          ],
        ),
      ),
    );
  }
}
