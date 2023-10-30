import 'package:flutter/material.dart';
import 'package:template/l10n/l10n.dart';

import '../../../../global/style/app_images.dart';
import '../../../../global/utilities/public.dart';

class HomeDescription extends StatelessWidget {
  const HomeDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Image.asset(AppImages.iHomeBody1)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Image.asset(AppImages.iHomeBody2)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: Image.asset(AppImages.iHomeBody3)),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: Public.desktopSize),
            child: Column(
              children: [
              ],
            ),
          )
        ],
      ),
    );
  }
}
