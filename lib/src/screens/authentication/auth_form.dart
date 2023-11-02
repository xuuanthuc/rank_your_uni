import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/global_bloc/authentication/authentication_bloc.dart';
import 'package:template/src/screens/authentication/widgets/auth_button.dart';
import 'package:template/src/screens/authentication/widgets/auth_field_label.dart';
import 'package:template/src/screens/authentication/widgets/google_auth_button.dart';
import 'package:template/src/screens/authentication/widgets/text_field_auth.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import 'package:template/src/screens/widgets/expandable_page_view.dart';

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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if(state.status == AuthenticationStatus.success) {
          context.pop();
        }
      },
      child: Dialog(
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

  void _onSignIn(BuildContext context) {
    context.read<AuthenticationBloc>().add(OnSignInEvent());
  }

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
        AuthFormLabel(
          theme,
          text: text.email,
        ),
        AuthTextField(
          theme: theme,
          text: text,
          hintText: text.enterEmail,
        ),
        const SizedBox(height: 26),
        AuthFormLabel(
          theme,
          text: text.password,
        ),
        AuthTextField(
          theme: theme,
          text: text,
          hintText: text.enterPassword,
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
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: 35),
        AuthButton(onTap: () => _onSignIn(context), label: text.signIn),
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
        AuthFormLabel(
          theme,
          text: text.email,
        ),
        AuthTextField(
          theme: theme,
          text: text,
          hintText: text.enterEmail,
        ),
        const SizedBox(height: 35),
        AppButton(
          onTap: () {},
          title: text.continueText,
          height: 56,
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
