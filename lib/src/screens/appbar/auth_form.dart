import 'package:flutter/material.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/global/style/app_images.dart';
import 'package:template/global/utilities/public.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/expandable_page_view.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 35),
        width: 400,
        constraints: const BoxConstraints(maxWidth: Public.mobileSize),
        child: SingleChildScrollView(
          child: ExpandablePageView(
            pageController: _pageController,
            pageIndex: widget.pageIndex,
            children: [
              SignInForm(
                onSignUp: () {
                  _pageController.jumpToPage(1);
                },
              ),
              SignUpForm(
                onSignIn: () {
                  _pageController.jumpToPage(0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({super.key, required this.onSignUp});

  final Function onSignUp;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text.signIn,
          style: theme.primaryTextTheme.displayLarge,
        ),
        const SizedBox(height: 45),
        AuthWithGoogleButton(
          theme: theme,
          text: text.signInWithGoogle,
          onAuthWithGoogle: () {},
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              text.orSignInWithEmail,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        AuthTextField(
          theme: theme,
          text: text,
        ),
        const SizedBox(height: 26),
        AuthTextField(
          theme: theme,
          text: text,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            AppButton(
                onTap: () {},
                hasBorder: false,
                title: text.forgetPassword,
                isOutline: true,
                titleTextStyleColor: theme.primaryColor,
                padding: EdgeInsets.zero),
          ],
        ),
        const SizedBox(height: 35),
        AppButton(
          onTap: () {},
          title: text.signIn,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        const SizedBox(height: 26),
        Text(
          text.authNotice,
          textAlign: TextAlign.center,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${text.notHaveAccount} ',
              style: theme.primaryTextTheme.bodyLarge?.copyWith(fontSize: 14),
            ),
            AppButton(
              onTap: () {
                onSignUp();
              },
              hasBorder: false,
              title: text.signUp,
              isOutline: true,
              titleTextStyleColor: theme.primaryColor,
              padding: EdgeInsets.zero,
            ),
          ],
        )
      ],
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.onSignIn,
  });

  final Function onSignIn;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text.signUp,
          style: theme.primaryTextTheme.displayLarge,
        ),
        const SizedBox(height: 45),
        AuthWithGoogleButton(
          theme: theme,
          text: text.signUpWithGoogle,
          onAuthWithGoogle: () {},
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              text.orSignUpWithEmail,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        AuthTextField(
          theme: theme,
          text: text,
        ),
        const SizedBox(height: 35),
        AppButton(
          onTap: () {},
          title: text.continueText,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        const SizedBox(height: 26),
        Text(
          text.authNotice,
          textAlign: TextAlign.center,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${text.alreadyHaveAccount} ',
              style: theme.primaryTextTheme.bodyLarge?.copyWith(fontSize: 14),
            ),
            AppButton(
              onTap: () {
                onSignIn();
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
    );
  }
}

class AuthTextField extends StatelessWidget {
  final ThemeData theme;
  final AppLocalizations text;

  const AuthTextField({
    super.key,
    required this.theme,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: theme.primaryTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: text.enterEmail,
        hintStyle: theme.primaryTextTheme.bodyLarge
            ?.copyWith(color: AppColors.textGrey),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.grey, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.grey, width: 1)),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}

class AuthWithGoogleButton extends StatelessWidget {
  final ThemeData theme;
  final String text;
  final Function onAuthWithGoogle;

  const AuthWithGoogleButton({
    super.key,
    required this.theme,
    required this.text,
    required this.onAuthWithGoogle,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onAuthWithGoogle(),
        child: ResponsiveBuilder(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: AppColors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(AppImages.iGoogleLogo),
                ),
                const SizedBox(width: 14),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: theme.primaryTextTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
