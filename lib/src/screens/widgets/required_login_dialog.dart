import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/screens/widgets/primary_button.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../di/dependencies.dart';
import '../authentication/auth_form.dart';
import '../authentication/bloc/auth_form_cubit.dart';

enum NoticeAbout { manager, private, vote }

class NoticeMustLoginDialog extends StatelessWidget {
  final NoticeAbout about;

  const NoticeMustLoginDialog({super.key, this.about = NoticeAbout.manager});


  Future<void> _showSignUpDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt.get<AuthFormCubit>(),
          child: const AuthForm(pageIndex: 1),
        );
      },
    ).then((value) => _updateUserProfile(context));
  }

  Future<void> _showSignInDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt.get<AuthFormCubit>(),
          child: const AuthForm(pageIndex: 0),
        );
      },
    ).then((value) => _updateUserProfile(context));
  }

  void _updateUserProfile(BuildContext context) {
    context.read<AppSettingsBloc>().add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    ItemDescription item = ItemDescription(
      text: text.managerAndEditYourRate,
      image: AppImages.iHomeManager,
    );
    if (about == NoticeAbout.manager) {
      item = ItemDescription(
        text: text.managerAndEditYourRate,
        image: AppImages.iHomeManager,
      );
    } else if (about == NoticeAbout.vote) {
      item = ItemDescription(
        text: text.likeOrDislike,
        image: AppImages.iHomeLike,
      );
    } else if (about == NoticeAbout.private) {
      item = ItemDescription(
        text: text.yourRateAlwaysAnonymous,
        image: AppImages.iHomePrivate,
      );
    }

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Container(
        constraints: const BoxConstraints(maxWidth: Public.tabletSize),
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                text.createAnAccount,
                style: theme.primaryTextTheme.displayLarge,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Text(
                  text.youNeedAnAccout,
                  style: theme.primaryTextTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              ResponsiveBuilder(
                smallView: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [item],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemDescription(
                      text: text.managerAndEditYourRate,
                      image: AppImages.iHomeManager,
                    ),
                    ItemDescription(
                      text: text.likeOrDislike,
                      image: AppImages.iHomeLike,
                    ),
                    ItemDescription(
                      text: text.yourRateAlwaysAnonymous,
                      image: AppImages.iHomePrivate,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    onTap: () {
                      context.pop();
                      _showSignUpDialog(context);
                    },
                    title: text.signUp,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${text.alreadyHaveAccount} ',
                    style: theme.primaryTextTheme.bodyLarge
                        ?.copyWith(fontSize: 14),
                  ),
                  PrimaryButton(
                    onTap: () {
                      context.pop();
                      _showSignInDialog(context);
                    },
                    hasBorder: false,
                    title: text.signIn,
                    isOutline: true,
                    titleTextStyleColor: theme.primaryColor,
                    padding: EdgeInsets.zero,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDescription extends StatelessWidget {
  final String text;
  final String image;

  const ItemDescription({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          width: Public.mobileSize * 0.3,
          child: Image.asset(image),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: theme.primaryTextTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
