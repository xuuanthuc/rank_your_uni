import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/global_bloc/settings/app_settings_bloc.dart';

import '../../../../global/routes/route_keys.dart';

class AppBarTextField extends StatefulWidget {
  final String? keyword;

  const AppBarTextField({
    super.key,
    this.keyword,
  });

  @override
  State<AppBarTextField> createState() => _AppBarTextFieldState();
}

class _AppBarTextFieldState extends State<AppBarTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(left: 10),
        child: BlocListener<AppSettingsBloc, AppSettingsState>(
          listener: (context, state) {
            _controller.clear();
          },
          listenWhen: (pre, cur) => cur.type != pre.type,
          child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
            builder: (context, state) {
              return TextField(
                controller: _controller,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                onEditingComplete: () {
                  if (_controller.text.trim().isEmpty) return;
                  context.goNamed(
                    state.type == SearchType.university
                        ? RouteKey.searchUniversity
                        : RouteKey.searchProfessor,
                    queryParameters: {"q": _controller.text.trim()},
                  );
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: state.type == SearchType.university
                      ? text.yourUniversity
                      : text.professorName,
                  hintStyle: theme.primaryTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.textGrey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hoverColor: Colors.transparent,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 12),
                    child: SvgPicture.asset(
                      AppImages.iSearch,
                      colorFilter: ColorFilter.mode(
                        theme.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                  isDense: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
