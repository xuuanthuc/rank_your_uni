import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../global/style/styles.dart';

class EditButton extends StatelessWidget {
  final Function onTap;
  final bool canEdit;

  const EditButton({
    super.key,
    required this.onTap,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment:
            canEdit ? MainAxisAlignment.end : MainAxisAlignment.center,
        children: [
          Visibility(
            visible: canEdit,
            child: SvgPicture.asset(AppImages.iEdit),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              canEdit
                  ? AppLocalizations.of(context)!.edit
                  : AppLocalizations.of(context)!.cannotEditProfile,
              style: canEdit
                  ? theme.primaryTextTheme.labelLarge
                  : theme.primaryTextTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
