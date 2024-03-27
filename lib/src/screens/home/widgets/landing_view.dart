import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../global/routes/route_keys.dart';
import '../../../global_bloc/settings/app_settings_bloc.dart';
import '../../widgets/responsive_builder.dart';
import 'package:template/global/style/styles.dart';
import '../../widgets/text_field_suggestion.dart';

class LandingView extends StatelessWidget {
  final Function(String, SearchType) onSearch;

  const LandingView({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      smallView: SizedBox(
        height: 350,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            const LandingBackground(height: 350),
            Container(color: Colors.black38),
            LandingContent(
              logoHeight: 40,
              contentPadding: 12,
              onSearch: (keyword, type) => onSearch(keyword, type),
            ),
          ],
        ),
      ),
      child: SizedBox(
        height: 500,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            const LandingBackground(height: 500),
            Container(color: Colors.black38),
            LandingContent(
              logoHeight: 60,
              contentPadding: 18,
              onSearch: (keyword, type) => onSearch(keyword, type),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingBackground extends StatelessWidget {
  final double height;

  const LandingBackground({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.sizeOf(context).width,
      child: Image.asset(
        AppImages.iHomeBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}

class LandingContent extends StatelessWidget {
  final double logoHeight;
  final double contentPadding;
  final Function(String, SearchType) onSearch;

  const LandingContent({
    super.key,
    required this.logoHeight,
    required this.contentPadding,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: logoHeight,
                  child: Image.asset(AppImages.iHomeLogo),
                ),
                const SizedBox(height: 45),
                AutoSizeText(
                  state.type == SearchType.university
                      ? text.homeLargeTitle
                      : text.findYourProfessor,
                  style:
                      Theme.of(context).primaryTextTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  minFontSize: 14,
                ),
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: Public.tabletSize),
                  child: TextFieldAutocompleted(
                    onSelected: (university) {
                      context.goNamed(
                        RouteKey.university,
                        pathParameters: {"id": "${university.id}"},
                        extra: university,
                      );
                    },
                    onEditingComplete: (keyword) {
                      if (keyword.trim().isEmpty) return;
                      onSearch(
                          keyword.trim(), state.type ?? SearchType.university);
                    },
                    inputDecorationCustom: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: state.type == SearchType.university
                          ? text.yourUniversity
                          : text.professorName,
                      hintStyle: theme.primaryTextTheme.bodyLarge
                          ?.copyWith(color: AppColors.textGrey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      hoverColor: Colors.transparent,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 12),
                        child: SvgPicture.asset(AppImages.iStudentCap),
                      ),
                      contentPadding: EdgeInsets.all(contentPadding),
                      isDense: true,
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SelectionContainer.disabled(
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<AppSettingsBloc>()
                            .add(ChangeSearchTypeEvent());
                      },
                      child: AutoSizeText(
                        state.type == SearchType.university
                            ? text.findTeacher
                            : text.findUniversity,
                        minFontSize: 13,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: theme.primaryTextTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
