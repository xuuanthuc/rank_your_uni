import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../global/routes/route_keys.dart';
import '../../../../global/style/app_images.dart';


class AppBarLogo extends StatelessWidget {
  final bool isHome;

  const AppBarLogo({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.goNamed(RouteKey.home);
        },
        child: SvgPicture.asset(
          isHome ? AppImages.iLogoPrimary : AppImages.iLogoWhite,
        ),
      ),
    );
  }
}
