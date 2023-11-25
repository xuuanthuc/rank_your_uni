import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/src/models/response/province.dart';
import '../../../../global/style/styles.dart';
import '../../widgets/loading.dart';
import '../bloc/select_province_cubit.dart';

class ProvincesPage extends StatefulWidget {
  const ProvincesPage({
    super.key,
    required this.onSelect,
  });

  final Function(Province) onSelect;

  @override
  State<ProvincesPage> createState() => _ProvincesPageState();
}

class _ProvincesPageState extends State<ProvincesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return BlocBuilder<SelectProvinceCubit, SelectProvinceState>(
      buildWhen: (_, cur) => cur.action == SelectedAction.init,
      builder: (context, state) {
        if (state.searchingProvinces != null) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () =>
                    widget.onSelect((state.searchingProvinces ?? [])[index]),
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
                        (state.searchingProvinces ?? [])[index].name ?? '',
                        style: theme.primaryTextTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: state.searchingProvinces?.length,
          );
        }
        return LoadingCommon(
          state.status == SelectStatus.loading,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
