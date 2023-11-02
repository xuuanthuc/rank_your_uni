import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
        if (state.action == AuthenticationAction.signIn &&
            state.isSuccess == true &&
            state.status == AuthenticationStatus.authenticated) {
          context.pop();
        } else if (state.action == AuthenticationAction.signUp &&
            state.isSuccess == true &&
            state.status == AuthenticationStatus.unauthenticated) {
          _pageController.animateToPage(
            3,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Container(
          constraints: const BoxConstraints(maxWidth: Public.mobileSize),
          child: SingleChildScrollView(
            child: ExpandablePageView(
              pageController: _pageController,
              pageIndex: widget.pageIndex,
              children: [
                SignInForm(
                  goSignUp: () {
                    _pageController.jumpToPage(1);
                  },
                ),
                SignUpEmailForm(
                  goSignIn: () {
                    _pageController.jumpToPage(0);
                  },
                  continueSignUp: () {
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
                SignUpPasswordForm(
                  onRegister: () {
                    context.read<AuthenticationBloc>().add(OnSignUpEvent());
                  },
                  onPrevious: () {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
                UpdateUserProfileForm(
                  onComplete: () {},
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
  const SignInForm({super.key, required this.goSignUp});

  final Function goSignUp;

  void _onSignIn(BuildContext context) {
    context.read<AuthenticationBloc>().add(OnSignInEvent());
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 35, horizontal: setHorizontalDialogPadding(context)),
      child: Column(
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
                  goSignUp();
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
      ),
    );
  }
}

class SignUpEmailForm extends StatelessWidget {
  const SignUpEmailForm({
    super.key,
    required this.goSignIn,
    required this.continueSignUp,
  });

  final Function goSignIn;
  final Function continueSignUp;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: setHorizontalDialogPadding(context), vertical: 35),
      child: Column(
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
            onTap: () => continueSignUp(),
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
                  goSignIn();
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
    );
  }
}

class SignUpPasswordForm extends StatelessWidget {
  const SignUpPasswordForm({
    super.key,
    required this.onRegister,
    required this.onPrevious,
  });

  final Function onRegister;
  final Function onPrevious;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => onPrevious(),
                  icon: SvgPicture.asset(
                    AppImages.iBack,
                  ),
                ),
                Text(
                  text.createPassword,
                  style: theme.primaryTextTheme.displayLarge,
                ),
                Opacity(
                  opacity: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppImages.iBack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: setHorizontalDialogPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 93),
                AuthFormLabel(
                  theme,
                  text: text.password,
                ),
                AuthTextField(
                  theme: theme,
                  text: text,
                  hintText: text.enterPassword,
                ),
                const SizedBox(height: 8),
                Text(
                  text.passwordAtLeast,
                  style: theme.primaryTextTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  text.createPasswordDescription,
                  textAlign: TextAlign.center,
                  style:
                      theme.primaryTextTheme.bodyLarge?.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 25),
                AuthButton(
                  onTap: () => onRegister(),
                  label: text.continueText,
                ),
                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UpdateUserProfileForm extends StatelessWidget {
  const UpdateUserProfileForm({
    super.key,
    required this.onComplete,
  });

  final Function onComplete;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 35,
        horizontal: setHorizontalDialogPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text.updateProfile,
            style: theme.primaryTextTheme.displayLarge,
          ),
          const SizedBox(height: 51),
          AuthFormLabel(
            theme,
            text: text.lastName,
          ),
          AuthTextField(
            theme: theme,
            text: text,
            hintText: text.enterLastName,
          ),
          const SizedBox(height: 25),
          AuthFormLabel(
            theme,
            text: text.firstName,
          ),
          AuthTextField(
            theme: theme,
            text: text,
            hintText: text.enterFirstName,
          ),
          const SizedBox(height: 25),
          AuthFormLabel(
            theme,
            text: text.universityName,
          ),
          AuthTextField(
            theme: theme,
            text: text,
            hintText: text.whatIsYourUniversity,
          ),
          const SizedBox(height: 30),
          AuthButton(
            onTap: () {},
            label: text.completeRegister,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

double setHorizontalDialogPadding(BuildContext context) {
  if (MediaQuery.sizeOf(context).width < Public.mobileSize) {
    return 35;
  } else if (MediaQuery.sizeOf(context).width > Public.mobileSize &&
      MediaQuery.sizeOf(context).width < Public.tabletSize) {
    return 40;
  } else if (MediaQuery.sizeOf(context).width > Public.tabletSize &&
      MediaQuery.sizeOf(context).width < Public.laptopSize) {
    return 50;
  } else if (MediaQuery.sizeOf(context).width > Public.laptopSize &&
      MediaQuery.sizeOf(context).width < Public.desktopSize) {
    return 60;
  } else if (MediaQuery.sizeOf(context).width > Public.desktopSize) {
    return 70;
  }
  return 70;
}
