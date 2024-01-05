import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/src/screens/review/bloc/review_cubit.dart';

import '../../../../global/style/styles.dart';
import '../../widgets/primary_button.dart';

class ReviewArea extends StatelessWidget {
  final TextEditingController controller;

  const ReviewArea({
    super.key,
    required this.controller,
  });

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      text.tooltipWriteReview,
                      style: theme.primaryTextTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
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
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(AppImages.iProtect)),
                              const SizedBox(width: 4),
                              Text(
                                text.guideline,
                                style: theme.primaryTextTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          GuidelineBasic(text: text.guidelineBasic1),
                          GuidelineBasic(text: text.guidelineBasic2),
                          GuidelineBasic(text: text.guidelineBasic3),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: Row(
                              children: [
                                PrimaryButton(
                                  onTap: () =>
                                      context.goNamed(RouteKey.guidelines),
                                  hasBorder: false,
                                  title: text.seeAllGuideline,
                                  isOutline: true,
                                  titleTextStyleColor: AppColors.black,
                                  fontSize: 13,
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
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
              maxLines: 7,
              maxLength: 500,
              controller: controller,
              onChanged: (value) {
                if (value.length > 500) return;
                context.read<ReviewCubit>().updateContent(value);
              },
              decoration: InputDecoration(
                hintText: text.placeHolderReview,
                hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                  color: AppColors.textGrey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuidelineBasic extends StatelessWidget {
  final String text;

  const GuidelineBasic({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 7,
            width: 7,
            margin: const EdgeInsets.all(6.5).copyWith(left: 0),
            decoration: BoxDecoration(
                color: AppColors.black, borderRadius: BorderRadius.circular(5)),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
