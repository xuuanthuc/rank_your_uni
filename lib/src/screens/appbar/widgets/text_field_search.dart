import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../global/style/app_colors.dart';
import '../../../../global/style/app_images.dart';
import '../../../../l10n/l10n.dart';

class AppBarTextField extends StatelessWidget {
  final ThemeData theme;
  final AppLocalizations text;
  final Function onSearch;

  const AppBarTextField({
    super.key,
    required this.theme,
    required this.text,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          cursorHeight: 18,
          onEditingComplete: () => onSearch(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: text.yourUniversity,
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
              child: SvgPicture.asset(AppImages.iStudentCap),
            ),
            contentPadding: const EdgeInsets.all(4),
            isDense: true,
          ),
        ),
      ),
    );
  }
}
