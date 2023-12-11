import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/src/screens/authentication/widgets/text_field_auth.dart';
import '../../../../global/style/styles.dart';
import '../../../../global/validators/validators.dart';
import '../../../global_bloc/authentication/authentication_bloc.dart';
import '../../widgets/loading_primary_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/responsive_builder.dart';
import '../bloc/auth_form_cubit.dart';
import 'auth_field_label.dart';
import 'google_auth_button.dart';

class SignUpEmailForm extends StatefulWidget {
  const SignUpEmailForm({
    super.key,
    required this.goSignIn,
    required this.continueSignUp,
  });

  final Function goSignIn;
  final Function(String) continueSignUp;

  @override
  State<SignUpEmailForm> createState() => _SignUpEmailFormState();
}

class _SignUpEmailFormState extends State<SignUpEmailForm> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSignGoogleSignIn(BuildContext context) {
    context.read<AuthenticationBloc>().add(OnGoogleSignUpEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveBuilder.setHorizontalPadding(context),
          vertical: 35,
        ),
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
              onAuthWithGoogle: () => _onSignGoogleSignIn(context),
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
            AuthTextField.email(
              theme: theme,
              text: text,
              hintText: text.enterEmail,
              controller: _emailController,
            ),
            SizedBox(
              height: 55,
              child: BlocBuilder<AuthFormCubit, AuthFormState>(
                builder: (context, state) {
                  if (state.error != null) {
                    return Center(
                      child: Text(
                        state.error ?? '',
                        style: theme.primaryTextTheme.labelLarge
                            ?.copyWith(color: AppColors.error),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            PrimaryButton(
              onTap: () {
                if (TextFieldValidator.emailValidator(_emailController.text) !=
                    null) {
                  context
                      .read<AuthFormCubit>()
                      .showError(error: text.invalidEmail);
                } else {
                  widget.continueSignUp(_emailController.text.trim());
                }
              },
              title: text.continueText,
              height: 46,
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
                  style:
                      theme.primaryTextTheme.bodyLarge?.copyWith(fontSize: 14),
                ),
                PrimaryButton(
                  onTap: () {
                    widget.goSignIn();
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
    );
  }
}

class SignUpPasswordForm extends StatefulWidget {
  const SignUpPasswordForm({
    super.key,
    required this.onRegister,
    required this.onPrevious,
  });

  final Function(String) onRegister;
  final Function onPrevious;

  @override
  State<SignUpPasswordForm> createState() => _SignUpPasswordFormState();
}

class _SignUpPasswordFormState extends State<SignUpPasswordForm> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

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
                  onPressed: () => widget.onPrevious(),
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
                horizontal: ResponsiveBuilder.setHorizontalPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 93),
                AuthFormLabel(
                  theme,
                  text: text.password,
                ),
                AuthTextField.password(
                  theme: theme,
                  text: text,
                  hintText: text.enterPassword,
                  controller: _passwordController,
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
                SizedBox(
                  height: 55,
                  child: BlocBuilder<AuthFormCubit, AuthFormState>(
                    builder: (context, state) {
                      if (state.error != null) {
                        return Center(
                          child: Text(
                            state.error ?? '',
                            style: theme.primaryTextTheme.labelLarge
                                ?.copyWith(color: AppColors.error),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                LoadingPrimaryButton<AuthenticationBloc, AuthenticationState>(
                  onTap: () {
                    if (TextFieldValidator.passValidator(
                            _passwordController.text) !=
                        null) {
                      context
                          .read<AuthFormCubit>()
                          .showError(error: text.invalidPassword);
                    } else {
                      widget.onRegister(
                        _passwordController.text.trim(),
                      );
                    }
                  },
                  label: text.continueText,
                  updateLoading: (state) {
                    return (state).isLoading ?? false;
                  },
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
