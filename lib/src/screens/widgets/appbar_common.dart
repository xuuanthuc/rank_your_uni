import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/global/style/app_images.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

class AppbarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primary,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 0,
      titleSpacing: 0,
      title: ResponsiveBuilder(
        smallView: SvgPicture.asset(
          AppImages.iMenu,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              child: SizedBox(
                  height: kToolbarHeight - 20,
                  child: SvgPicture.asset(AppImages.iLogoWhite)),
            ),
            Expanded(
              child: TextField(

              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
