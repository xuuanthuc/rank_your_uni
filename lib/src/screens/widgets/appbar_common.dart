import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/global/style/app_images.dart';
import 'package:template/global/utilities/public.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

class AppbarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCommon({super.key});

  final double _appbarHeight = 60;

  @override
  Widget build(BuildContext context) {
    String currentRoute = GoRouterState.of(context).matchedLocation;
    bool isHome = currentRoute == RouteKey.home;
    ThemeData theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isHome ? Colors.white : theme.primaryColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 0,
      titleSpacing: 0,
      centerTitle: true,
      toolbarHeight: _appbarHeight,
      title: Container(
        width: MediaQuery.sizeOf(context).width,
        height: _appbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        constraints: const BoxConstraints(maxWidth: Public.desktopSize),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ResponsiveBuilder(
                smallView: Container(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Image.asset(AppImages.iHomeHeaderBackground),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: _appbarHeight * 3 / 5,
                child: ResponsiveBuilder(
                  smallView: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppImages.iMenu,
                          colorFilter: ColorFilter.mode(
                            isHome ? theme.primaryColor : Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            context.go(RouteKey.home);
                          },
                          child: SizedBox(
                            child: SvgPicture.asset(
                              isHome
                                  ? AppImages.iLogoPrimary
                                  : AppImages.iLogoWhite,
                            ),
                          ),
                        ),
                      ),
                      !isHome
                          ? const Expanded(
                              child: TextField(),
                            )
                          : const Spacer(),
                      Row(
                        children: [
                          AppButton(
                            onTap: () {},
                            title: text.signIn,
                            isOutline: true,
                            titleTextStyle:
                                theme.primaryTextTheme.labelLarge?.copyWith(
                              color: theme.primaryColor,
                            ),
                            height: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                          ),
                          const SizedBox(width: 16),
                          AppButton(
                            onTap: () {},
                            title: text.signUp,
                            height: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appbarHeight);
}
