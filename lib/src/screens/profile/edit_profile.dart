import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = BlocProvider.of<AppSettingsBloc>(context).state;
      _firstNameController.text = state.profileAuthenticated?.firstName ?? '';
      _lastNameController.text = state.profileAuthenticated?.lastName ?? '';
      _universityController.text = state.profileAuthenticated?.university ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

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
                RowInfoField(
                  label: text.lastName,
                  hintText: text.enterLastName,
                  controller: _lastNameController,
                ),
                const SizedBox(height: 25),
                RowInfoField(
                  label: text.firstName,
                  hintText: text.enterFirstName,
                  controller: _firstNameController,
                ),
                const SizedBox(height: 25),
                RowInfoField(
                  label: text.universityName,
                  hintText: text.whatIsYourUniversity,
                  controller: _universityController,
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
    _lastNameController.dispose();
    _firstNameController.dispose();
    _universityController.dispose();
  }
}
