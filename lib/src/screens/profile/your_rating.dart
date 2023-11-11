import 'package:flutter/material.dart';

import '../../../global/utilities/public.dart';
import '../detail/widgets/reviews.dart';
import '../widgets/responsive_builder.dart';

class YourRatings extends StatelessWidget {
  const YourRatings({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Public.tabletSize),
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveBuilder.setHorizontalPadding(context),
          ),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: (((index + 1) % 3) == 0) ? 75 : 0,
                    ),
                    child: const ReviewItem(),
                  );
                },
                itemCount: 20,
                separatorBuilder: (_, __) => const SizedBox(height: 30),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
