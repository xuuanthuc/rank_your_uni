import 'package:flutter/material.dart';
import 'package:template/src/screens/detail/widgets/overall.dart';
import 'package:template/src/screens/detail/widgets/reviews.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

import '../../../global/style/styles.dart';

class UniversityDetail extends StatelessWidget {
  final int id;

  const UniversityDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child:  AppScaffold(
        children: [
          Center(
            child: Stack(
              children: [
                Image.asset(AppImages.iDetailBackground),
                const Column(
                  children: [
                    UniversityOverview(),
                    ReviewsBuilder(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
