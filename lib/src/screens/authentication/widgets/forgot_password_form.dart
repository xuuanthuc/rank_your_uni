import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/screens/authentication/widgets/text_field_auth.dart';

import '../../../../global/style/styles.dart';
import '../../../../global/validators/validators.dart';
import '../../../global_bloc/authentication/authentication_bloc.dart';
import '../../widgets/loading_primary_button.dart';
import '../bloc/auth_form_cubit.dart';
import 'auth_field_label.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _forgotPassword(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    if (TextFieldValidator.emailValidator(_emailController.text.trim()) !=
        null) {
      context.read<AuthFormCubit>().showError(error: text.invalidEmail);
    } else {
      context
          .read<AuthenticationBloc>()
          .add(OnForgotPasswordEvent(_emailController.text));
    }
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text.forgetPassword,
            style: theme.primaryTextTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 45),
          Text(
            text.enterYourEmailToResetPassword,
            textAlign: TextAlign.center,
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
            onEditingComplete: () => _forgotPassword(context),
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
            onTap: () => _forgotPassword(context),
            label: text.resetPassword,
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
        ],
      ),
    );
  }
}
