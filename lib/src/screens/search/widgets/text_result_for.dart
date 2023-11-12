import 'package:flutter/material.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import '../../../../global/style/styles.dart';

class TextResultUniversities extends StatelessWidget {
  final String? keyword;

  const TextResultUniversities({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Visibility(
      visible: (keyword ?? "").isNotEmpty,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Public.desktopSize),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal:
                          ResponsiveBuilder.setHorizontalPadding(context))
                  .copyWith(
                bottom: 40 - 25 / 2,
              ),
              child: SelectionArea(
                child: Text(
                  text.resultsForSearch(keyword ?? ""),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
