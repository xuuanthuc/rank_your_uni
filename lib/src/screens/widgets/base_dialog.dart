import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../global/style/app_images.dart';
import '../../../global/utilities/public.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final bool hasScrollBody;
  final EdgeInsetsGeometry? padding;

  const BaseDialog({
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
