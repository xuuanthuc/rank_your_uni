import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/global/style/styles.dart';

class AppBarTextField extends StatefulWidget {
  final ThemeData theme;
  final AppLocalizations text;
  final Function onSearch;
  final String? keyword;

  const AppBarTextField({
    super.key,
    required this.theme,
    required this.text,
    required this.onSearch,
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
          controller: _controller,
          style: widget.theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          cursorHeight: 18,
          onEditingComplete: () => widget.onSearch(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.text.yourUniversity,
            hintStyle: widget.theme.primaryTextTheme.bodyLarge
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
