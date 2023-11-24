import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/src/screens/add/bloc/add_university_cubit.dart';
import 'package:template/src/screens/widgets/loading.dart';
import '../../../../global/style/styles.dart';

class SelectProvinceDialog extends StatefulWidget {
  const SelectProvinceDialog({super.key});

  @override
  State<SelectProvinceDialog> createState() => _SelectProvinceDialogState();
}

class _SelectProvinceDialogState extends State<SelectProvinceDialog> {
  @override
  void initState() {
    super.initState();
    context.read<AddUniversityCubit>().getVNAddress();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      child: Container(
        constraints: const BoxConstraints(maxWidth: Public.mobileSize),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Text(
                text.cityOrProvince,
                style: theme.primaryTextTheme.labelLarge,
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  context.read<AddUniversityCubit>().filterProvince(value);
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.grey,
                    ),
                  ),
                  hintText: text.search,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.grey,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.transparent,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: AppColors.grey,
                ),
              ),
              BlocBuilder<AddUniversityCubit, AddUniversityState>(
                builder: (context, state) {
                  print(state.searchingProvinces?.length);
                  if (state.searchingProvinces != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              overlayColor:
                                  MaterialStateProperty.all(AppColors.level4),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child:
                                        SvgPicture.asset(AppImages.iLocation),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    (state.searchingProvinces ?? [])[index]
                                            .name ??
                                        '',
                                    style: theme.primaryTextTheme.labelLarge,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: state.searchingProvinces?.length,
                      ),
                    );
                  }
                  return LoadingCommon(state.status == AddUniStatus.loading);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
