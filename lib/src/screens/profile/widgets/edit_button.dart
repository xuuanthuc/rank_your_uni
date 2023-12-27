import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../global/style/styles.dart';

class EditButton extends StatelessWidget {
  final Function onTap;

  const EditButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(AppImages.iEdit),
          const SizedBox(width: 4),
          Text(
            AppLocalizations.of(context)!.edit,
            style: theme.primaryTextTheme.labelLarge,
          )
        ],
      ),
    );
  }
}
