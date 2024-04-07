import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';

import '../../../global_bloc/settings/app_settings_bloc.dart';

class SeachTypeButton extends StatelessWidget {
  const SeachTypeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PopupMenuButton(
              color: Colors.white,
              tooltip: text.seachType,
              surfaceTintColor: Colors.transparent,
              itemBuilder: (context) => [
                if (state.type == SearchType.professor)
                  PopupMenuItem(
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.iStudentCap),
                        const SizedBox(width: 8),
                        Text(
                          text.school,
                          style: theme.primaryTextTheme.titleLarge,
                        ),
                      ],
                    ),
                    onTap: () => context
                        .read<AppSettingsBloc>()
                        .add(ChangeSearchTypeEvent()),
                  ),
                if (state.type == SearchType.university)
                  PopupMenuItem(
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.iTie),
                        Text(
                          text.professor,
                          style: theme.primaryTextTheme.titleLarge,
                        ),
                      ],
                    ),
                    onTap: () => context
                        .read<AppSettingsBloc>()
                        .add(ChangeSearchTypeEvent()),
                  ),
              ],
              child: ResponsiveBuilder(
                mediumView: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        state.type == SearchType.university
                            ? AppImages.iStudentCap
                            : AppImages.iTie,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        state.type == SearchType.university
                            ? AppImages.iStudentCap
                            : AppImages.iTie,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                          width: state.type == SearchType.university ? 8 : 0),
                      Text(
                        state.type == SearchType.university
                            ? text.school
                            : text.professor,
                        style: theme.primaryTextTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
