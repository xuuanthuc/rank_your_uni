import 'package:flutter/material.dart';

import '../../../../global/style/styles.dart';

class NoUniversityToCompare extends StatelessWidget {
  final Function onCompare;

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
              TextField(
                onTap: () => onCompare(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.grey,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.transparent,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
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