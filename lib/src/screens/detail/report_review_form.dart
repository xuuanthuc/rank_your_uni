import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../global/style/styles.dart';
import '../widgets/button_common.dart';

class ReportReviewForm extends StatelessWidget {
  const ReportReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Container(
        constraints: const BoxConstraints(maxWidth: Public.tabletSize),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: SizedBox(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          AppImages.iSheetClose,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveBuilder.setHorizontalPadding(context),
                ),
                child: Column(
                  children: [
                    Text(
                      text.reportReview,
                      style: theme.primaryTextTheme.labelLarge,
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
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    text.youAreReportingReview,
                                    style: theme.primaryTextTheme.labelLarge,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ',
                                    style: theme.primaryTextTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 25),
                                  Text(
                                    text.whatIsMatter,
                                    style: theme.primaryTextTheme.labelLarge,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    text.whatIsMatterDescription,
                                    style: theme.primaryTextTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: text.reportContent,
                        hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                          color: AppColors.textGrey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: theme.primaryColor, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: theme.primaryColor, width: 1)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      child: AppButton(
                        onTap: () {},
                        title: text.report,
                      ),
                    ),
                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
