import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/text_field_suggestion.dart';

import '../../../../global/style/styles.dart';

class NoUniversityToCompare extends StatelessWidget {
  final Function(int) onCompare;

  const NoUniversityToCompare({
    super.key,
    required this.onCompare,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryShadow,
        ),
        padding: const EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.level0,
                ),
                margin: const EdgeInsets.all(7),
                width: 70,
                height: 70,
              ),
              const Spacer(),
              TextFieldAutocompleted(
                onSelected: (university) => onCompare(university.id),
              ),
              const SizedBox(height: 20),
              Text(
                text.nameUniversity,
                style: theme.primaryTextTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
