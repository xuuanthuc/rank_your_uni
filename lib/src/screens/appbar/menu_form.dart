import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/global/utilities/public.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/screens/appbar/widgets/logo_appbar.dart';
import '../../../global/style/app_images.dart';
import '../widgets/button_common.dart';

class MenuFormHeader extends StatefulWidget {
  final Function onSignIn;
  final Function onSignUp;

  const MenuFormHeader({
    super.key,
    required this.onSignUp,
    required this.onSignIn,
  });

  @override
  State<MenuFormHeader> createState() => _MenuFormHeaderState();
}

class _MenuFormHeaderState extends State<MenuFormHeader>  {

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if(MediaQuery.sizeOf(context).width > Public.tabletSize) {
    //     if(mounted) {
    //       context.pop();
    //     }
    //   }
    // });
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
              Text(
                text.hello(''),
                style: theme.primaryTextTheme.displayMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    onTap: () {
                      context.pop();
                      widget.onSignIn();
                    },
                    hasBorder: false,
                    title: text.signIn,
                    isOutline: true,
                    titleTextStyleColor: AppColors.black,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    onTap: () {
                      context.pop();
                      widget.onSignUp();
                    },
                    hasBorder: false,
                    title: text.signUp,
                    isOutline: true,
                    titleTextStyleColor: AppColors.black,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
