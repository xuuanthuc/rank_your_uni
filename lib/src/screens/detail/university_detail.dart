import 'package:flutter/material.dart';
import 'package:template/src/screens/appbar/appbar_common.dart';
import 'package:template/src/screens/detail/widgets/overall.dart';
import 'package:template/src/screens/detail/widgets/reviews.dart';

import '../../../global/style/styles.dart';

class UniversityDetail extends StatelessWidget {
  final int id;

  const UniversityDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppbarCommon(onSearch: () {}),
        body: SingleChildScrollView(
          child: Center(
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
        ),
      ),
    );
  }
}
