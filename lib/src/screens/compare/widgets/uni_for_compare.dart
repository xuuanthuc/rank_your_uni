import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/button_common.dart';
import '../../../../global/style/styles.dart';
import '../../../models/response/university.dart';
import '../../widgets/point_container.dart';

class UniversityCompared extends StatelessWidget {
  final University university;
  final bool isFirst;
  final Function onChange;

  const UniversityCompared({
    super.key,
    required this.university,
    required this.isFirst,
    required this.onChange,
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
        child: Column(
          children: [
            PointContainer.medium(point: university.averagePointAllReviews ?? 0),
            const SizedBox(height: 3),
            Text(
              text.reviewCount(university.reviews?.length ?? 0),
              style: theme.primaryTextTheme.labelLarge,
            ),
            const SizedBox(height: 26),
            Text(
              university.name ?? '',
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge,
            ),
            if (!isFirst) const SizedBox(height: 20),
            if (!isFirst)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    onTap: () => onChange(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    title: text.changeUniversity,
                    fontSize: 12,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
