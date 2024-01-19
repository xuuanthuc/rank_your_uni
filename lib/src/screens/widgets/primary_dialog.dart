import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/screens/widgets/primary_button.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../global/style/app_images.dart';
import '../../../global/utilities/public.dart';

class PrimaryDialog extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final bool hasScrollBody;
  final EdgeInsetsGeometry? padding;

  const PrimaryDialog({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.hasScrollBody = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? Public.mobileSize,
            ),
            padding: padding ??
                EdgeInsets.all(
                  ResponsiveBuilder.setHorizontalPadding(context),
                ),
            child: hasScrollBody
                ? SingleChildScrollView(
                    child: child,
                  )
                : child,
          ),
          Visibility(
            visible: MediaQuery.sizeOf(context).width <=
                (maxWidth ?? Public.tabletSize),
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: maxWidth ?? Public.mobileSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
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
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryConfirmDialog extends StatelessWidget {
  final String title;
  final String description;

  const PrimaryConfirmDialog({
    super.key,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: Public.mobileSize,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      AppImages.iSheetClose,
                    ),
                  ),
                )
              ],
            ),
            const Divider(color: AppColors.primaryShadow),
            Text(
              description,
              style: theme.primaryTextTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                  onTap: () => context.pop(false),
                  hasBorder: false,
                  title: text.cancel,
                  isOutline: true,
                  titleTextStyleColor: theme.primaryColor,
                ),
                const SizedBox(width: 20),
                PrimaryButton(
                  onTap: () => context.pop(true),
                  title: text.confirm,
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
