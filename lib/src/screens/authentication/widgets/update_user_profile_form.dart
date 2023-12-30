import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/screens/authentication/widgets/text_field_auth.dart';
import '../../../../global/style/styles.dart';
import '../../../global_bloc/settings/app_settings_bloc.dart';
import '../../../models/request/profile_request.dart';
import '../../widgets/loading_primary_button.dart';
import '../../widgets/primary_button.dart';
import 'auth_field_label.dart';

class UpdateUserProfileForm extends StatefulWidget {
  const UpdateUserProfileForm({super.key});

  @override
  State<UpdateUserProfileForm> createState() => _UpdateUserProfileFormState();
}

class _UpdateUserProfileFormState extends State<UpdateUserProfileForm> {
  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _universityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _universityController.dispose();
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
          text.updateProfile,
          style: theme.primaryTextTheme.displayLarge,
        ),
        const SizedBox(height: 51),
        AuthFormLabel(
          theme,
          text: text.lastName,
        ),
        AuthTextField.normal(
          theme: theme,
          text: text,
          hintText: text.enterLastName,
          controller: _lastNameController,
          maxLength: 20,
        ),
        const SizedBox(height: 25),
        AuthFormLabel(
          theme,
          text: text.firstName,
        ),
        AuthTextField.normal(
          theme: theme,
          text: text,
          hintText: text.enterFirstName,
          controller: _firstNameController,
          maxLength: 10,
        ),
        const SizedBox(height: 25),
        AuthFormLabel(
          theme,
          text: text.universityName,
        ),
        AuthTextField.normal(
          theme: theme,
          text: text,
          hintText: text.whatIsYourUniversity,
          controller: _universityController,
        ),
        const SizedBox(height: 30),
        LoadingPrimaryButton<AppSettingsBloc, AppSettingsState>(
          onTap: () {
            final state = BlocProvider.of<AppSettingsBloc>(context).state;
            ProfileRaw profile = ProfileRaw(
              id: state.profileAuthenticated?.id ?? -1,
              username: state.profileAuthenticated?.username ?? '',
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              university: _universityController.text,
              email: state.profileAuthenticated?.email ?? '',
            );
            context
                .read<AppSettingsBloc>()
                .add(UpdateUserProfileEvent(profile));
            context.pop();
          },
          label: text.completeRegister,
          updateLoading: (state) {
            return state.status == AppSettingStatus.loading;
          },
        ),
        const SizedBox(height: 25),
        PrimaryButton(
          onTap: () {
            context.pop();
          },
          hasBorder: false,
          title: text.skipForNow,
          isOutline: true,
          titleTextStyleColor: theme.primaryColor,
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
