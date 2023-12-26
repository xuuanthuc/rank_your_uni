import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/models/request/password_request.dart';
import 'package:template/src/screens/profile/profile_screen.dart';
import 'package:template/src/screens/profile/widgets/edit_button.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../global_bloc/settings/app_settings_bloc.dart';
import '../../models/request/profile_request.dart';
import '../widgets/loading_primary_button.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyPass = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = BlocProvider.of<AppSettingsBloc>(context).state;
      _emailController.text = state.profileAuthenticated?.username ?? '';
    });
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Public.tabletSize),
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveBuilder.setHorizontalPadding(context),
          ),
          child: Form(
            key: _formKey,
            child: Form(
              key: _formKeyPass,
              child: Column(
                children: [
                  SizedBox(
                      height: ResponsiveBuilder.setHorizontalPadding(context)),
                  EditButton(onTap: () {}),
                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelField(text.email),
                      Expanded(
                        child: TextFieldData(
                          text.enterEmail,
                          _emailController,
                          validator: TextFieldValidator.emailValidator,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<AppSettingsBloc, AppSettingsState>(
                        builder: (context, state) {
                          return LoadingPrimaryButton<AppSettingsBloc,
                              AppSettingsState>(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                ProfileRaw profile = ProfileRaw(
                                  id: state.profileAuthenticated?.id ?? -1,
                                  username: _emailController.text,
                                  firstName:
                                      state.profileAuthenticated?.firstName ??
                                          '',
                                  lastName:
                                      state.profileAuthenticated?.lastName ??
                                          '',
                                  university:
                                      state.profileAuthenticated?.university ??
                                          '',
                                  email: _emailController.text,
                                );
                                context
                                    .read<AppSettingsBloc>()
                                    .add(UpdateUserProfileEvent(profile));
                              }
                            },
                            label: text.updateAccount,
                            buttonWidth: 250,
                            updateLoading: (state) {
                              return (state).status ==
                                      AppSettingStatus.loading &&
                                  state.action ==
                                      AppSettingAction.updateProfile;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelField(text.password),
                      Expanded(
                        child: TextFieldData(
                          text.enterPassword,
                          _passwordController,
                          validator: TextFieldValidator.passValidator,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelField(text.newPassword),
                      Expanded(
                        child: TextFieldData(
                          text.enterPassword,
                          _newPasswordController,
                          validator: TextFieldValidator.passValidator,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<AppSettingsBloc, AppSettingsState>(
                        builder: (context, state) {
                          return LoadingPrimaryButton<AppSettingsBloc,
                              AppSettingsState>(
                            onTap: () {
                              if (_formKeyPass.currentState!.validate()) {
                                PasswordRaw password = PasswordRaw(
                                  currentPassword: _passwordController.text,
                                  newPassword: _newPasswordController.text,
                                );
                                context
                                    .read<AppSettingsBloc>()
                                    .add(UpdatePasswordEvent(password));
                              }
                            },
                            label: text.updatePassword,
                            buttonWidth: 250,
                            updateLoading: (state) {
                              return state.status == AppSettingStatus.loading &&
                                  state.action ==
                                      AppSettingAction.changePassword;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
  }
}
