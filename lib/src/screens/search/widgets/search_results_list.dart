import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import '../../../../global/style/styles.dart';
import 'university_card.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        constraints: const BoxConstraints(maxWidth: Public.desktopSize),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: (((index + 1) % 3) == 0) ? 75 : 0,
              ),
              child: UniversityCard(
                onTap: () {
                  context.goNamed(RouteKey.university, pathParameters: {"id": "500"});
                },
              ),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
