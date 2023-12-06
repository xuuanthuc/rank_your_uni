import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/screens/authentication/bloc/auth_form_cubit.dart';
import 'package:template/src/screens/authentication/widgets/text_field_auth.dart';
import '../../../../global/style/styles.dart';
import '../../../../global/validators/validators.dart';
import '../../../global_bloc/authentication/authentication_bloc.dart';
import '../../../models/request/sign_in_with_email_request.dart';
import '../../widgets/loading_primary_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/responsive_builder.dart';
import 'auth_field_label.dart';
import 'google_auth_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key, required this.goSignUp});

  final Function goSignUp;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onSignIn(BuildContext context, SignInWithEmailRaw signInRequest) {
    context
        .read<AuthenticationBloc>()
        .add(OnSignInWithEmailEvent(signInRequest));
  }

  void _onSignGoogleSignIn(BuildContext context) {
    context.read<AuthenticationBloc>().add(OnGoogleSignInEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 35,
          horizontal: ResponsiveBuilder.setHorizontalPadding(context)),
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
            controller: _emailController,
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
            controller: _passwordController,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              PrimaryButton(
                onTap: () {},
                hasBorder: false,
                title: text.forgetPassword,
                isOutline: true,
                titleTextStyleColor: theme.primaryColor,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          SizedBox(
            height: 55,
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (prev, cur) =>
                  prev.isError != cur.isError &&
                  cur.action == AuthenticationAction.signIn,
              listener: (context, state) {
                if (state.isError == true &&
                    state.action == AuthenticationAction.signIn) {
                  context
                      .read<AuthFormCubit>()
                      .showError(error: text.invalidLoginCredentials);
                }
              },
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
          ),
          LoadingPrimaryButton<AuthenticationBloc, AuthenticationState>(
            onTap: () {
              if (TextFieldValidator.emailValidator(_emailController.text) !=
                  null) {
                context
                    .read<AuthFormCubit>()
                    .showError(error: text.invalidEmail);
              } else if (TextFieldValidator.passValidator(
                      _passwordController.text) !=
                  null) {
                context
                    .read<AuthFormCubit>()
                    .showError(error: text.invalidPassword);
              } else {
                _onSignIn(
                  context,
                  SignInWithEmailRaw(
                    username: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
            label: text.signIn,
            updateLoading: (state) {
              return (state).isLoading ?? false;
            },
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
              PrimaryButton(
                onTap: () {
                  widget.goSignUp();
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
