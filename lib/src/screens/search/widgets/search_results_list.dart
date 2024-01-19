import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/src/screens/search/bloc/search_cubit.dart';
import 'package:template/src/screens/widgets/loading.dart';
import '../../../../global/style/styles.dart';
import 'university_card.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (prev, curr) =>
          curr.status == SearchStatus.init ||
          curr.status == SearchStatus.success ||
          curr.status == SearchStatus.error,
      builder: (context, state) {
        if (state.status == SearchStatus.init) {
          return Padding(
            padding: const EdgeInsets.only(top: 80),
            child: PrimaryCircularLoading(state.status == SearchStatus.init),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: (((index + 1) % 3) == 0) ? 75 : 0,
              ),
              child: UniversityCard(
                university: (state.universities ?? [])[index],
                onTap: () {
                  context.goNamed(RouteKey.university,
                      pathParameters: {
                        "id": "${(state.universities ?? [])[index].id}"
                      },
                      extra: (state.universities ?? [])[index]);
                },
              ),
            );
          },
          itemCount: (state.universities ?? []).length,
        );
      },
    );
  }
}
