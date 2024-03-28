import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../global/style/styles.dart';
import '../bloc/search_cubit.dart';

class TextResult extends StatelessWidget {
  final String? keyword;

  const TextResult({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (prev, curt) => prev.status == SearchStatus.init,
      builder: (context, state) {
        if (state.universities == null) {
          return const SizedBox.shrink();
        }
        return Visibility(
          visible: (keyword ?? "").isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40).copyWith(
              bottom: 40 - 25 / 2,
            ),
            child: Text(
              text.resultsForSearch(
                keyword ?? "",
                state.searchModel?.totalElements ?? 0,
              ),
            ),
          ),
        );
      },
    );
  }
}
