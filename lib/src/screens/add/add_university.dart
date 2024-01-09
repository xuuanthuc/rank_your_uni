import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/validators/validators.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/request/add_university_request.dart';
import 'package:template/src/screens/add/bloc/add_university_cubit.dart';
import 'package:template/src/screens/add/bloc/select_province_cubit.dart';
import 'package:template/src/screens/add/widgets/add_university_dialog_success.dart';
import 'package:template/src/screens/add/widgets/select_province_dialog.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import 'package:template/src/screens/widgets/loading_primary_button.dart';
import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';
import '../widgets/responsive_builder.dart';

class AddUniversity extends StatelessWidget {
  const AddUniversity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<AddUniversityCubit>(),
      child: const AddUniversityView(),
    );
  }
}

class AddUniversityView extends StatefulWidget {
  const AddUniversityView({super.key});

  @override
  State<AddUniversityView> createState() => _AddUniversityViewState();
}

class _AddUniversityViewState extends State<AddUniversityView> {
  Future<void> _selectProvince(BuildContext context) async {
    final res = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt.get<SelectProvinceCubit>(),
          child: const SelectProvinceDialog(),
        );
      },
    );
    if (res != null) {
      if (!context.mounted) return;
      context.read<AddUniversityCubit>().onSelectedProvinceDistrict(
            res['province'],
            res['district'],
          );
    }
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _districtController = TextEditingController();

  final TextEditingController _websiteController = TextEditingController();

  final TextEditingController _abbreviaController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _websiteController.dispose();
    _abbreviaController.dispose();
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
      _nameController.clear();
      _provinceController.clear();
      _districtController.clear();
      _websiteController.clear();
      _abbreviaController.clear();
      context.read<AddUniversityCubit>().clearAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      children: [
        Center(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(
                ResponsiveBuilder.setHorizontalPadding(context),
              ),
              constraints: const BoxConstraints(
                maxWidth: Public.laptopSize,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: Public.mobileSize,
                  ),
                  child: BlocListener<AddUniversityCubit, AddUniversityState>(
                    listener: (context, state) {
                      if (state.status == AddUniStatus.success) {
                        _showNoticeRequestAddUniversitySuccess(
                          context,
                          state.addUniversityRaw,
                        );
                      } else if (state.status == AddUniStatus.error) {
                        appToast(
                          context,
                          message: AppLocalizations.of(context)!.somethingWrong,
                          subMessage:
                              AppLocalizations.of(context)!.tryAgainLater,
                        );
                      }
                    },
                    child: BlocBuilder<AddUniversityCubit, AddUniversityState>(
                      builder: (context, state) {
                        _provinceController.text =
                            state.addUniversityRaw?.province?.name ?? '';
                        _districtController.text =
                            state.addUniversityRaw?.districts?.name ?? '';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text.addAUniversity,
                              style: theme.primaryTextTheme.displayLarge,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              text.addAUniversityWarning,
                              style: theme.primaryTextTheme.bodyMedium
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(height: 30),
                            TextAddField(
                              label: text.nameOfUniversity,
                              controller: _nameController,
                            ),
                            TextAddField(
                              label: text.abbrevia,
                              controller: _abbreviaController,
                            ),
                            TextAddField(
                              label: text.cityOrProvince,
                              readOnly: true,
                              onTap: () => _selectProvince(context),
                              controller: _provinceController,
                            ),
                            TextAddField(
                              label: text.stateOrWard,
                              readOnly: true,
                              onTap: () => _selectProvince(context),
                              controller: _districtController,
                            ),
                            TextAddField(
                              label: text.website,
                              controller: _websiteController,
                            ),
                            Row(
                              children: [
                                BlocBuilder<AddUniversityCubit,
                                    AddUniversityState>(
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
                                          context
                                              .read<AddUniversityCubit>()
                                              .onCheckPrivacy();
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
                                LoadingPrimaryButton<AddUniversityCubit,
                                    AddUniversityState>(
                                  buttonWidth: 270,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<AddUniversityCubit>()
                                          .submitAddUniversity(
                                            name: _nameController.text,
                                            website: _websiteController.text,
                                            code: _abbreviaController.text,
                                          );
                                    }
                                  },
                                  label: text.addUniversity,
                                  updateLoading: (state) {
                                    return (state).status ==
                                        AddUniStatus.loading;
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
              ),
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
