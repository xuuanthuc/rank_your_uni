import 'package:flutter/material.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/widgets/button_common.dart';

class LoadMoreUniversities extends StatelessWidget {
  const LoadMoreUniversities({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            const SizedBox(height: 75),
            AppButton(onTap: () {}, title: text.seeMore),
            const SizedBox(height: 25),
            SelectionArea(
              child: Text(
                text.noResultForUniversity,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            AppButton(
              onTap: () {},
              hasBorder: false,
              title: text.addUniversity,
              isOutline: true,
              titleTextStyleColor: AppColors.black,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
