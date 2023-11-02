import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/global/style/styles.dart';

class MenuIcon extends StatelessWidget {
  final bool isHome;
  final ThemeData theme;
  final Function onTap;

  const MenuIcon(
      {super.key,
        required this.isHome,
        required this.theme,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTap(),
      icon: SvgPicture.asset(
        AppImages.iMenu,
        colorFilter: ColorFilter.mode(
          isHome ? theme.primaryColor : Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}