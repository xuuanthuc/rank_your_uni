import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/global/style/app_images.dart';
import 'package:template/global/utilities/public.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/screens/widgets/auth_form.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../global/style/app_colors.dart';

class AppbarCommon extends StatefulWidget implements PreferredSizeWidget {
  final Function onSearch;

  const AppbarCommon({
    super.key,
    required this.onSearch,
  });

  @override
  State<AppbarCommon> createState() => _AppbarCommonState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppbarCommonState extends State<AppbarCommon> {
  final double _appbarHeight = 60;

  Future<void> _showSignUpDialog() {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const AuthForm(pageIndex: 1);
      },
    );
  }

  Future<void> _showSignInDialog() {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const AuthForm(pageIndex: 0);
      },
    );
  }

  void _onToggleMenu() {}

  void _onToggleSearchField() {}

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
                smallView: const SizedBox(),
                child: isHome
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset(AppImages.iHomeHeaderBackground),
                      )
                    : const SizedBox(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: _appbarHeight * 3 / 5,
                child: ResponsiveBuilder(
                  mediumView: isHome
                      ? null
                      : Row(
                          children: [
                            AppBarLogo(isHome: isHome),
                            !isHome
                                ? AppBarTextField(
                                    theme: theme,
                                    text: text,
                                    onSearch: () => widget.onSearch(),
                                  )
                                : const Spacer(),
                            MenuIcon(
                              isHome: isHome,
                              theme: theme,
                              onTap: () => _onToggleMenu(),
                            )
                          ],
                        ),
                  smallView: IntrinsicHeight(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MenuIcon(
                            isHome: isHome,
                            theme: theme,
                            onTap: () => _onToggleMenu(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: AppBarLogo(isHome: isHome),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: isHome
                              ? Container()
                              : IconButton(
                                  onPressed: () => _onToggleSearchField(),
                                  icon: SvgPicture.asset(
                                    AppImages.iSearch,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBarLogo(isHome: isHome),
                      !isHome
                          ? AppBarTextField(
                              theme: theme,
                              text: text,
                              onSearch: () => widget.onSearch(),
                            )
                          : const Spacer(),
                      Row(
                        children: [
                          AppButton(
                            onTap: () => _showSignInDialog(),
                            hasBorder: false,
                            title: text.signIn,
                            isOutline: true,
                            titleTextStyleColor:
                                isHome ? theme.primaryColor : Colors.white,
                            height: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                          ),
                          const SizedBox(width: 16),
                          AppButton(
                            onTap: () => _showSignUpDialog(),
                            title: text.signUp,
                            height: double.infinity,
                            borderColor:
                                isHome ? theme.primaryColor : Colors.white,
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
}

class MenuIcon extends StatelessWidget {
  final bool isHome;
  final ThemeData theme;
  final Function onTap;

  const MenuIcon(
      {super.key,
      required this.isHome,
      required this.theme,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTap(),
      icon: SvgPicture.asset(
        AppImages.iMenu,
        colorFilter: ColorFilter.mode(
          isHome ? theme.primaryColor : Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class AppBarTextField extends StatelessWidget {
  final ThemeData theme;
  final AppLocalizations text;
  final Function onSearch;

  const AppBarTextField({
    super.key,
    required this.theme,
    required this.text,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          cursorHeight: 18,
          onEditingComplete: () => onSearch(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: text.yourUniversity,
            hintStyle: theme.primaryTextTheme.bodyLarge
                ?.copyWith(color: AppColors.textGrey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hoverColor: Colors.transparent,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: SvgPicture.asset(AppImages.iStudentCap),
            ),
            contentPadding: const EdgeInsets.all(4),
            isDense: true,
          ),
        ),
      ),
    );
  }
}

class AppBarLogo extends StatelessWidget {
  final bool isHome;

  const AppBarLogo({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.go(RouteKey.home);
        },
        child: SvgPicture.asset(
          isHome ? AppImages.iLogoPrimary : AppImages.iLogoWhite,
        ),
      ),
    );
  }
}
