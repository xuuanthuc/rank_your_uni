import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import 'package:template/src/screens/appbar/menu_form.dart';
import 'package:template/src/screens/appbar/widgets/logo_appbar.dart';
import 'package:template/src/screens/appbar/widgets/menu_appbar_icon.dart';
import 'package:template/src/screens/appbar/widgets/text_field_search.dart';
import 'package:template/src/screens/appbar/widgets/user_button.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../authentication/auth_form.dart';
import 'bloc/appbar_cubit.dart';
import 'package:template/global/style/styles.dart';

class AppbarCommon extends StatelessWidget implements PreferredSizeWidget {
  final String? keyword;

  const AppbarCommon({
    super.key,
    this.keyword,
  });

  final double _appbarHeight = 60;

  void _updateUserProfile(BuildContext context) {
    context.read<AuthenticationBloc>().add(OnCompleteSignUpEvent());
  }

  Future<void> _showSignUpDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const AuthForm(pageIndex: 1);
      },
    ).then((value) => _updateUserProfile(context));
  }

  Future<void> _showSignInDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return const AuthForm(pageIndex: 0);
      },
    ).then((value) => _updateUserProfile(context));
  }

  Future<void> _onToggleMenu(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return MenuFormHeader(
          onSignIn: () {
            _showSignInDialog(context);
          },
          onSignUp: () {
            _showSignUpDialog(context);
          },
        );
      },
    );
  }

  void _onToggleSearchField(BuildContext context) {
    context.read<AppbarCubit>().changeSmallTextFieldState();
  }

  @override
  Widget build(BuildContext context) {
    String currentRoute = GoRouterState.of(context).matchedLocation;
    bool isHome = currentRoute == '/';
    ThemeData theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if ((state.action == AuthenticationAction.signOut ||
                state.action == AuthenticationAction.signIn) &&
            state.isSuccess == true) {
          context.goNamed(RouteKey.home);
        }
      },
      child: BlocProvider(
        create: (context) => getIt.get<AppbarCubit>(),
        child: AppBar(
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
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveBuilder.setHorizontalPadding(context)),
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
                                        keyword: keyword,
                                      )
                                    : const Spacer(),
                                MenuIcon(
                                  isHome: isHome,
                                  theme: theme,
                                  onTap: () => _onToggleMenu(context),
                                )
                              ],
                            ),
                      smallView: IntrinsicHeight(
                        child: BlocBuilder<AppbarCubit, AppbarState>(
                          buildWhen: (_, current) =>
                              current.status == AppbarStatus.searchField,
                          builder: (context, state) {
                            if (state.onShowSmallTextField == true && !isHome) {
                              return Row(
                                children: [
                                  AppBarTextField(
                                    theme: theme,
                                    text: text,
                                    keyword: keyword,
                                  ),
                                  AppButton(
                                    onTap: () => _onToggleSearchField(context),
                                    hasBorder: false,
                                    title: text.cancel,
                                    isOutline: true,
                                    titleTextStyleColor: Colors.white,
                                    height: double.infinity,
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              );
                            }
                            return Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: MenuIcon(
                                    isHome: isHome,
                                    theme: theme,
                                    onTap: () => _onToggleMenu(context),
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
                                          onPressed: () =>
                                              _onToggleSearchField(context),
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
                            );
                          },
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
                                  keyword: keyword,
                                )
                              : const Spacer(),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            buildWhen: (prev, cur) => cur.status != prev.status,
                            builder: (context, state) {
                              if (state.status ==
                                  AuthenticationStatus.authenticated) {
                                return UserQuickButton(isHome: isHome);
                              }
                              return Row(
                                children: [
                                  AppButton(
                                    onTap: () => _showSignInDialog(context),
                                    hasBorder: false,
                                    title: text.signIn,
                                    isOutline: true,
                                    titleTextStyleColor: isHome
                                        ? theme.primaryColor
                                        : Colors.white,
                                    height: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 0,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  AppButton(
                                    onTap: () => _showSignUpDialog(context),
                                    title: text.signUp,
                                    height: double.infinity,
                                    borderColor: isHome
                                        ? theme.primaryColor
                                        : Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 0,
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
