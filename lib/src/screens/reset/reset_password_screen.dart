import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/utilities/logger.dart';
import 'package:template/src/models/request/reset_password_request.dart';
import 'package:template/src/screens/authentication/widgets/auth_field_label.dart';
import 'package:template/src/screens/authentication/widgets/text_field_auth.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import '../../../global/routes/route_keys.dart';
import '../../../global/utilities/toast.dart';
import '../../../global/validators/validators.dart';
import '../../di/dependencies.dart';
import '../widgets/loading_primary_button.dart';
import 'bloc/reset_password_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String resetKey;

  const ResetPasswordScreen({
    super.key,
    required this.resetKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ResetPasswordCubit>(),
      child: ResetPasswordView(resetKey: resetKey),
    );
  }
}

class ResetPasswordView extends StatefulWidget {
  final String resetKey;

  const ResetPasswordView({
    super.key,
    required this.resetKey,
  });

  @override
  State<ResetPasswordView> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordView> {
  final TextEditingController _editingController = TextEditingController();

  void _resetPassword(BuildContext context, String key) {
    final text = AppLocalizations.of(context)!;
    if (TextFieldValidator.passValidator(_editingController.text.trim()) !=
        null) {
      context.read<ResetPasswordCubit>().showError(text.invalidPassword);
    } else {
      context.read<ResetPasswordCubit>().onResetPassword(ResetPasswordRaw(
        newPassword: _editingController.text,
        key: key,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    LoggerUtils.i("widget.resetKey");
    LoggerUtils.i(widget.resetKey);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      children: [
        Center(
          child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if(state.status == ResetStatus.error) {
                appToast(
                  context,
                  message: AppLocalizations.of(context)!.somethingWrong,
                  subMessage: AppLocalizations.of(context)!.expiredUrl,
                );
              }
              if(state.status == ResetStatus.success) {
                appToast(
                  context,
                  message: AppLocalizations.of(context)!.welcomeBack,
                  subMessage: AppLocalizations.of(context)!.resetPasswordSuccess,
                  type: ToastType.success,
                );
                context.goNamed(RouteKey.home);
              }
            },
            child: Container(
              constraints: const BoxConstraints(maxWidth: Public.mobileSize),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Text(
                    text.resetPassword,
                    style: theme.primaryTextTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 35),
                  Text(
                    text.enterNewPassword,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  AuthFormLabel(
                    theme,
                    text: text.newPassword,
                  ),
                  AuthTextField.password(
                    theme: theme,
                    text: text,
                    hintText: text.newPassword,
                    controller: _editingController,
                    onEditingComplete: () =>
                        _resetPassword(context, widget.resetKey),
                  ),
                  SizedBox(
                    height: 55,
                    child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                      builder: (context, state) {
                        if (state.errorMessage != null) {
                          return Center(
                            child: Text(
                              state.errorMessage ?? '',
                              style: theme.primaryTextTheme.labelLarge
                                  ?.copyWith(color: AppColors.error),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  LoadingPrimaryButton<ResetPasswordCubit, ResetPasswordState>(
                    onTap: () => _resetPassword(context, widget.resetKey),
                    label: text.resetPassword,
                    updateLoading: (state) {
                      return state.status == ResetStatus.loading;
                    },
                  ),
                  const SizedBox(height: 26),
                  Text(
                    text.authNotice,
                    textAlign: TextAlign.center,
                    style:
                    theme.primaryTextTheme.bodyLarge?.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
