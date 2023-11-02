import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import 'package:template/global/style/styles.dart';
import '../../../global/routes/route_keys.dart';

class FooterCommon extends StatelessWidget {
  const FooterCommon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Container(
      color: theme.primaryColor,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ResponsiveBuilder(
        smallView: SizedBox(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _logo(context),
              _textCopyRight(text, theme),
            ],
          ),
        ),
        child: Center(
          child: Container(
            height: 80,
            constraints: const BoxConstraints(maxWidth: Public.desktopSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textCopyRight(text, theme),
                _logo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _textCopyRight(AppLocalizations text, ThemeData theme) {
    return Text(
      text.copyRight,
      style: theme.primaryTextTheme.bodyMedium?.copyWith(
        color: Colors.white,
      ),
    );
  }

  SizedBox _logo(BuildContext context) {
    return SizedBox(
      height: 36,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            context.go(RouteKey.home);
          },
          child: SvgPicture.asset(AppImages.iLogoWhite),
        ),
      ),
    );
  }
}
