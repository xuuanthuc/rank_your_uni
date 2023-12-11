import 'package:flutter/material.dart';
import 'package:template/src/screens/authentication/widgets/text_field_auth.dart';
import '../../../../global/style/styles.dart';
import '../../../global_bloc/authentication/authentication_bloc.dart';
import '../../widgets/loading_primary_button.dart';
import '../../widgets/responsive_builder.dart';
import 'auth_field_label.dart';

class UpdateUserProfileForm extends StatefulWidget {
  const UpdateUserProfileForm({
    super.key,
    required this.onComplete,
  });

  final Function onComplete;

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
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 35,
        horizontal: ResponsiveBuilder.setHorizontalPadding(context),
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
          AuthTextField.normal(
            theme: theme,
            text: text,
            hintText: text.enterLastName,
            controller: _lastNameController,
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
          LoadingPrimaryButton<AuthenticationBloc, AuthenticationState>(
            onTap: () {},
            label: text.completeRegister,
            updateLoading: (state) {
              return (state).isLoading ?? false;
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
