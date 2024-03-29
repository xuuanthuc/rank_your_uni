import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/routes/route_keys.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/screens/search/bloc/search_cubit.dart';
import 'package:template/src/screens/widgets/primary_button.dart';

import '../../widgets/loading.dart';

class LoadMoreUniversities extends StatelessWidget {
  const LoadMoreUniversities({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (prev, curt) => prev.status == SearchStatus.init,
      builder: (context, state) {
        if (state.universities == null) {
          return const SizedBox.shrink();
        }
        return Center(
          child: SizedBox(
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (prev, curr) =>
                      curr.status == SearchStatus.loadingMore ||
                      curr.status == SearchStatus.success,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: PrimaryCircularLoading(
                        state.status == SearchStatus.loadingMore,
                      ),
                    );
                  },
                ),
                BlocBuilder<SearchCubit, SearchState>(
                    buildWhen: (prev, curr) =>
                        prev.status == SearchStatus.init ||
                        curr.searchModel?.totalElements ==
                            curr.universities?.length,
                    builder: (context, state) {
                      if ((state.universities ?? []).isNotEmpty &&
                          state.searchModel?.totalElements !=
                              state.universities?.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: PrimaryButton(
                            onTap: () =>
                                context.read<SearchCubit>().loadMoreUniversities(),
                            title: text.seeMore,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                const SizedBox(height: 25),
                SelectionArea(
                  child: Text(
                    text.noResultForUniversity,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  onTap: () => context.goNamed(RouteKey.addUniversity),
                  hasBorder: false,
                  title: text.addUniversity,
                  isOutline: true,
                  titleTextStyleColor: AppColors.black,
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}
