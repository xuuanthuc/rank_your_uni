import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/add/bloc/add_university_cubit.dart';
import 'package:template/src/screens/add/bloc/select_province_cubit.dart';
import 'package:template/src/screens/add/widgets/select_province_dialog.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import '../../../global/style/styles.dart';
import '../widgets/button_common.dart';
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

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _districtController = TextEditingController();

  final TextEditingController _websiteController = TextEditingController();

  final TextEditingController _creatorEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      children: [
        Center(
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
                        TextAddField(
                          label: text.yourEmail,
                          controller: _creatorEmailController,
                        ),
                        Row(
                          children: [
                            BlocBuilder<AddUniversityCubit, AddUniversityState>(
                              builder: (context, state) {
                                return Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: theme.primaryColor,
                                    side: const BorderSide(color: AppColors.grey, width: 1),
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
                            AppButton(
                              onTap: () => {},
                              title: text.addUniversity,
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
        TextField(
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          controller: controller,
          readOnly: readOnly,
          onTap: () => onTap!(),
          cursorHeight: 18,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
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
