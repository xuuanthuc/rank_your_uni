import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import 'package:template/src/screens/appbar/widgets/logo_appbar.dart';
import '../widgets/button_common.dart';

class MenuFormHeader extends StatelessWidget {
  final Function onSignIn;
  final Function onSignUp;

  const MenuFormHeader({
    super.key,
    required this.onSignUp,
    required this.onSignIn,
  });

  void _signOut(BuildContext context){
    context.read<AuthenticationBloc>().add(OnSignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations text = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.white,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                toolbarHeight: 60,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                leadingWidth: 0,
                titleSpacing: 0,
                centerTitle: true,
                title: SizedBox(
                  height: 60 * 3 / 5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: SvgPicture.asset(
                            AppImages.iClose,
                            colorFilter: ColorFilter.mode(
                              theme.primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: AppBarLogo(isHome: true),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                buildWhen: (prev, cur) =>
                    cur.status != prev.status,
                builder: (context, state) {
                  if (state.status == AuthenticationStatus.authenticated) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text.hey("Thuc"),
                          style: theme.primaryTextTheme.displayMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 28),
                        MenuOption(
                          onTap: () {},
                          label: text.profile,
                        ),
                        MenuOption(
                          onTap: () {},
                          label: text.settingAccount,
                        ),
                        MenuOption(
                          onTap: () {},
                          label: text.yourRating,
                        ),
                        MenuOption(
                          onTap: () => _signOut(context),
                          label: text.signOut,
                        ),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text.hello,
                        style: theme.primaryTextTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 28),
                      MenuOption(
                        onTap: () {
                          context.pop();
                          onSignIn();
                        },
                        label: text.signIn,
                      ),
                      MenuOption(
                        onTap: () {
                          context.pop();
                          onSignUp();
                        },
                        label: text.signUp,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  final Function onTap;
  final String label;

  const MenuOption({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            onTap: () => onTap(),
            hasBorder: false,
            title: label,
            isOutline: true,
            titleTextStyleColor: AppColors.black,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
