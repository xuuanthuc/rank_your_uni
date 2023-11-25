import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/models/response/province.dart';
import 'package:template/src/screens/add/bloc/select_province_cubit.dart';

class DistrictsPage extends StatelessWidget {
  final Function(Province?, Districts) onSelect;

  const DistrictsPage({
    super.key,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SelectProvinceCubit, SelectProvinceState>(
      builder: (context, state) {
        if (state.searchingDistrics != null) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {
                  onSelect(state.provinceSelected,
                      (state.searchingDistrics ?? [])[index]);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  overlayColor: MaterialStateProperty.all(AppColors.level4),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(AppImages.iLocation),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        (state.searchingDistrics ?? [])[index].name ?? '',
                        style: theme.primaryTextTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: state.searchingDistrics?.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
