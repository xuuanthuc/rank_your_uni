import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import 'package:template/src/screens/widgets/primary_button.dart';
import '../../../global/routes/route_keys.dart';
import '../widgets/responsive_builder.dart';

class ReviewSuccessScreen extends StatefulWidget {
  final University university;

  const ReviewSuccessScreen({
    super.key,
    required this.university,
  });

  @override
  State<ReviewSuccessScreen> createState() => _ReviewSuccessScreenState();
}

class _ReviewSuccessScreenState extends State<ReviewSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(children: [
      if (widget.university.name != null)
        Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: Public.tabletSize,
            ),
            padding: EdgeInsets.all(
              ResponsiveBuilder.setHorizontalPadding(context),
            ),
            child: Stack(
              children: [
                SvgPicture.asset(AppImages.iSuccessBg),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      SvgPicture.asset(AppImages.iHandHeart),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          text.thanksForReviewUniversity(
                              widget.university.name ?? ''),
                          style: theme.textTheme.labelLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        text.yourReviewAreSubmitting,
                        style: theme.primaryTextTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 200,
                        child: PrimaryButton(
                          onTap: () {
                            context.goNamed(
                              RouteKey.university,
                              pathParameters: {"id": "${widget.university.id}"},
                              extra: widget.university,
                            );
                          },
                          title: text.seeReview,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    ]);
  }
}
