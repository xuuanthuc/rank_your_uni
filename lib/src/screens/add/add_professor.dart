import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/request/add_university_request.dart';
import 'package:template/src/screens/add/bloc/add_cubit.dart';
import 'package:template/src/screens/add/widgets/add_university_dialog_success.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import 'package:template/src/screens/widgets/loading_primary_button.dart';
import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';
import '../widgets/bloc/autocompletion_cubit.dart';
import '../widgets/text_field_suggestion.dart';

class AddProfessor extends StatelessWidget {
  const AddProfessor({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<AutocompletionCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<AddCubit>(),
        ),
      ],
      child: const AddProfessorView(),
    );
  }
}

class AddProfessorView extends StatefulWidget {
  const AddProfessorView({super.key});

  @override
  State<AddProfessorView> createState() => _AddProfessorViewState();
}

class _AddProfessorViewState extends State<AddProfessorView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _universityController = TextEditingController();

  final TextEditingController _majorController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _universityController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  void _showNoticeRequestAddUniversitySuccess(
    BuildContext context,
    AddUniversityRaw? university,
  ) {
    if (university == null) return;
    showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return AddUniversityDialogSuccess(university: university);
      },
    ).then((value) {
      _fullNameController.clear();
      _universityController.clear();
      _majorController.clear();
      context.read<AddCubit>().clearAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      alignment: Alignment.topLeft,
      maxContentWidth: Public.tabletSize,
      children: [
        Form(
          key: _formKey,
          child: BlocListener<AddCubit, AddState>(
            listener: (context, state) {
              if (state.status == AddStatus.success) {
                _showNoticeRequestAddUniversitySuccess(
                  context,
                  state.addUniversityRaw,
                );
              } else if (state.status == AddStatus.error) {
                appToast(
                  context,
                  message: AppLocalizations.of(context)!.somethingWrong,
                  subMessage: AppLocalizations.of(context)!.tryAgainLater,
                );
              }
            },
            child: BlocBuilder<AddCubit, AddState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text.addAProfessor,
                      style: theme.primaryTextTheme.displayLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      text.addAProfessorWarning,
                      style: theme.primaryTextTheme.bodyMedium
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 30),
                    TextAddField(
                      label: text.universityName,
                      controller: _universityController,
                    ),
                    TextFieldAutocompleted(
                      onSelected: (university) {
                        _universityController.text = university.name ?? "";
                      },
                      inputDecorationCustom: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 1, color: AppColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 1, color: AppColors.grey),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 1, color: AppColors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 1, color: AppColors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 1, color: AppColors.grey),
                        ),
                        hoverColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        isDense: true,
                      ),
                    ),
                    TextAddField(
                      label: text.professorName,
                      controller: _fullNameController,
                    ),
                    TextAddField(
                      label: text.major,
                      controller: _majorController,
                    ),
                    Row(
                      children: [
                        BlocBuilder<AddCubit, AddState>(
                          builder: (context, state) {
                            return Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: theme.primaryColor,
                                side: const BorderSide(
                                    color: AppColors.grey, width: 1),
                                value: state.acceptPrivacy ?? false,
                                onChanged: (bool? value) {
                                  context.read<AddCubit>().onCheckPrivacy();
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            text.agreeTermsOfUse,
                            style: theme.primaryTextTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingPrimaryButton<AddCubit, AddState>(
                          buttonWidth: 270,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          label: text.addProfessor,
                          updateLoading: (state) {
                            return (state).status == AddStatus.loading;
                          },
                          updateColor: (color) {
                            return state.acceptPrivacy != true
                                ? AppColors.grey
                                : null;
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TextAddField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final Function? onTap;
  final TextEditingController controller;

  const TextAddField({
    super.key,
    required this.label,
    this.readOnly = false,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.primaryTextTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        TextFormField(
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          validator: TextFieldValidator.notEmptyValidator,
          controller: controller,
          readOnly: readOnly,
          onTap: () {
            if (onTap == null) return;
            onTap!();
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            hoverColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            isDense: true,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
