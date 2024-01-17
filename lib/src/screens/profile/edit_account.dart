import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/models/request/password_request.dart';
import 'package:template/src/screens/profile/profile_screen.dart';
import 'package:template/src/screens/profile/widgets/edit_button.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../global_bloc/settings/app_settings_bloc.dart';
import '../widgets/loading_primary_button.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKeyPass = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = BlocProvider
          .of<AppSettingsBloc>(context)
          .state;
      _emailController.text = state.profileAuthenticated?.username ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return BlocListener<AppSettingsBloc, AppSettingsState>(
      listener: (context, state) {
        if (state.status == AppSettingStatus.success) {
          _emailController.text = state.profileAuthenticated?.username ?? '';
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: Public.tabletSize),
            margin: EdgeInsets.symmetric(
              horizontal: ResponsiveBuilder.setHorizontalPadding(context),
            ),
            child: Column(
              children: [
                SizedBox(
                    height: ResponsiveBuilder.setHorizontalPadding(context)),
                EditButton(onTap: () {}),
                const SizedBox(height: 25),
                RowInfoField(
                  label: text.email,
                  hintText: text.enterEmail,
                  controller: _emailController,
                  readOnly: true,
                  validator: TextFieldValidator.emailValidator,
                  maxLength: 80,
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKeyPass,
                  child: Column(
                    children: [
                      RowInfoField(
                        label: text.currentPassword,
                        hintText: text.enterPassword,
                        controller: _passwordController,
                        validator: TextFieldValidator.passValidator,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 25),
                      RowInfoField(
                        label: text.newPassword,
                        hintText: text.enterPassword,
                        controller: _newPasswordController,
                        validator: TextFieldValidator.passValidator,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
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
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
  }
}
