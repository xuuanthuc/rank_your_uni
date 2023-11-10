import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/screens/appbar/appbar_common.dart';
import 'package:template/src/screens/search/bloc/search_cubit.dart';
import 'package:template/src/screens/search/widgets/search_results_list.dart';
import 'package:template/src/screens/search/widgets/text_result_for.dart';
import 'package:template/src/screens/widgets/footer_common.dart';

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

class SearchView extends StatelessWidget {
  final String? keyword;

  const SearchView({
    super.key,
    this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(
        keyword: keyword,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextResultUniversities(keyword: keyword),
            const SearchResultsView(),
            const LoadMoreUniversities(),
            const FooterCommon(),
          ],
        ),
      ),
    );
  }
}
