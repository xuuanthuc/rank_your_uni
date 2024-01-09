import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/models/response/province.dart';
import 'package:template/src/screens/add/widgets/districts_page.dart';
import 'package:template/src/screens/add/widgets/provinces_page.dart';
import '../../../../global/style/styles.dart';
import '../../widgets/base_dialog.dart';
import '../bloc/select_province_cubit.dart';

class SelectProvinceDialog extends StatefulWidget {
  const SelectProvinceDialog({super.key});

  @override
  State<SelectProvinceDialog> createState() => _SelectProvinceDialogState();
}

class _SelectProvinceDialogState extends State<SelectProvinceDialog> {
  final PageController _controller = PageController();
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SelectProvinceCubit>().getVNAddress();
  }

  void _onSelectProvince(BuildContext context, Province province) {
    context.read<SelectProvinceCubit>().onSelectProvince(province);
  }

  void _onBackToProvince(BuildContext context) {
    context.read<SelectProvinceCubit>().onDeselectProvince();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return BlocListener<SelectProvinceCubit, SelectProvinceState>(
      listener: (context, state) {
        if (state.provinceSelected != null && _controller.page == 0) {
          _editingController.clear();
          _controller.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        } else if (state.provinceSelected == null && _controller.page == 1) {
          _editingController.clear();
          _controller.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      },
      child: BaseDialog(
        hasScrollBody: false,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<SelectProvinceCubit, SelectProvinceState>(
                  builder: (context, state) {
                    return Opacity(
                      opacity: state.provinceSelected == null ? 0 : 1,
                      child: IconButton(
                        onPressed: () => _onBackToProvince(context),
                        icon: SvgPicture.asset(
                          AppImages.iBack,
                          colorFilter: ColorFilter.mode(
                            theme.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<SelectProvinceCubit, SelectProvinceState>(
                    builder: (context, state) {
                      return AutoSizeText(
                        state.provinceSelected == null
                            ? text.cityOrProvince
                            : text.stateOrWard,
                        style: theme.primaryTextTheme.labelLarge,
                        minFontSize: 12,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        AppImages.iSheetClose,
                        colorFilter: ColorFilter.mode(
                          theme.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlocBuilder<SelectProvinceCubit, SelectProvinceState>(
              builder: (context, state) {
                return TextField(
                  controller: _editingController,
                  onChanged: (value) => state.provinceSelected == null
                      ? context
                          .read<SelectProvinceCubit>()
                          .filterProvince(value)
                      : context
                          .read<SelectProvinceCubit>()
                          .filterDistrics(value),
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
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                color: AppColors.grey,
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProvincesPage(
                    onSelect: (province) =>
                        _onSelectProvince(context, province),
                  ),
                  DistrictsPage(
                    onSelect: (province, district) {
                      if (province == null) {
                        context.pop();
                      } else {
                        context.pop({
                          "province": province,
                          "district": district,
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
