import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';
import 'package:template/src/models/request/profile_request.dart';
import 'package:template/src/screens/profile/profile_screen.dart';
import 'package:template/src/screens/profile/widgets/edit_button.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../widgets/loading_primary_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = BlocProvider.of<AppSettingsBloc>(context).state;
      _firstNameController.text = state.profileAuthenticated?.firstName ?? '';
      _lastNameController.text = state.profileAuthenticated?.lastName ?? '';
      _universityController.text = state.profileAuthenticated?.university ?? '';
    });
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: Public.tabletSize),
            margin: EdgeInsets.symmetric(
              horizontal: ResponsiveBuilder.setHorizontalPadding(context),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ResponsiveBuilder.setHorizontalPadding(context),
                ),
                EditButton(onTap: () {}),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelField(text.lastName),
                    Expanded(
                      child: TextFieldData(
                        text.enterLastName,
                        _lastNameController,
                        validator: TextFieldValidator.notEmptyValidator,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelField(text.firstName),
                    Expanded(
                      child: TextFieldData(
                        text.enterFirstName,
                        _firstNameController,
                        validator: TextFieldValidator.notEmptyValidator,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelField(text.universityName),
                    Expanded(
                      child: TextFieldData(
                        text.whatIsYourUniversity,
                        _universityController,
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
                                username:
                                    state.profileAuthenticated?.username ?? '',
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                university: _universityController.text,
                                email: state.profileAuthenticated?.email ?? '',
                              );
                              context
                                  .read<AppSettingsBloc>()
                                  .add(UpdateUserProfileEvent(profile));
                            }
                          },
                          label: text.updateProfile,
                          buttonWidth: 250,
                          updateLoading: (state) {
                            return (state).status == AppSettingStatus.loading;
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 500),
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
    _lastNameController.dispose();
    _firstNameController.dispose();
    _universityController.dispose();
  }
}
