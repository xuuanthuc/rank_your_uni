import 'package:flutter/material.dart';
import '../../../../global/style/styles.dart';

class TextResultUniversities extends StatelessWidget {
  final String? keyword;

  const TextResultUniversities({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Visibility(
      visible: (keyword ?? "").isNotEmpty,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        constraints: const BoxConstraints(maxWidth: Public.desktopSize),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50)
                  .copyWith(
                bottom: 40 - 25 / 2,
              ),
              child: Text(
                text.resultsForSearch(keyword ?? ""),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
