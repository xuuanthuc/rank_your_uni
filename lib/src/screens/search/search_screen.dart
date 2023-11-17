import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/global/utilities/toast.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/search/bloc/search_cubit.dart';
import 'package:template/src/screens/search/widgets/search_results_list.dart';
import 'package:template/src/screens/search/widgets/text_result_for.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';

import 'widgets/load_more_universities.dart';

class SearchScreen extends StatelessWidget {
  final String? keyword;

  const SearchScreen({super.key, this.keyword});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SearchCubit>(),
      child: SearchView(keyword: keyword),
    );
  }
}

class SearchView extends StatefulWidget {
  final String? keyword;

  const SearchView({
    super.key,
    this.keyword,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().onSearch(widget.keyword ?? "");
  }

  @override
  void didUpdateWidget(covariant SearchView oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<SearchCubit>().onSearch(widget.keyword ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listenWhen: (_, cur) => cur.status == SearchStatus.error,
      listener: (context, state) {
        appToast(
          context,
          message: AppLocalizations.of(context)!.somethingWrong,
          subMessage: AppLocalizations.of(context)!.tryAgainLater,
        );
      },
      child: AppScaffold(
        keyword: widget.keyword,
        children: [
          TextResultUniversities(keyword: widget.keyword),
          const SearchResultsView(),
          const LoadMoreUniversities(),
        ],
      ),
    );
  }
}
