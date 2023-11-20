import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import '../../../global/routes/route_keys.dart';
import '../widgets/button_common.dart';
import '../widgets/responsive_builder.dart';
import 'bloc/compare_cubit.dart';
import 'widgets/compare_criteria.dart';
import 'widgets/no_uni_for_compare.dart';
import 'widgets/uni_for_compare.dart';

class CompareScreen extends StatelessWidget {
  final String? universityId;
  final String? compareWithUniversityId;

  const CompareScreen({
    super.key,
    this.universityId,
    this.compareWithUniversityId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CompareCubit>(),
      child: SelectionArea(
        child: CompareView(
          universityId: universityId,
          compareWithUniversityId: compareWithUniversityId,
        ),
      ),
    );
  }
}

class CompareView extends StatefulWidget {
  final String? universityId;
  final String? compareWithUniversityId;

  const CompareView({
    super.key,
    required this.universityId,
    this.compareWithUniversityId,
  });

  @override
  State<CompareView> createState() => _CompareViewState();
}

class _CompareViewState extends State<CompareView> {
  @override
  void initState() {
    super.initState();
    if (widget.universityId != null) {
      context.read<CompareCubit>().initFirstUniversity(const University(1,
            name: "Trường Đại học Khoa học Xã hội và Nhân văn",
          ));
    }
    if (widget.compareWithUniversityId != null) {
      context.read<CompareCubit>().compareWith(const University(1,
            name:
                "Trường Đại học Khoa học Xã hội và Nhân văn - Đại học Quốc gia Thành Phố Hồ Chí Minh",
          ));
    }
  }

  void _goCompare(BuildContext context, {String? id, String? withUniId}) {
    Map<String, String> param = {
      "id": "100",
    };
    String route = RouteKey.compare;
    if (id == null) {
      return;
    } else if (withUniId != null) {
      param = {
        "id": "100",
        "withUniId": "200",
      };
      route = RouteKey.compareWith;
    }
    context.goNamed(
      route,
      pathParameters: param,
    );
  }

  void _resetUniversity(bool resetAll) {
    if (resetAll) {
      context.goNamed(
        RouteKey.reset,
      );
    } else {
      context.goNamed(
        RouteKey.compare,
        pathParameters: {
          "id": "100",
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.all(
              ResponsiveBuilder.setHorizontalPadding(context),
            ),
            constraints: const BoxConstraints(
              maxWidth: Public.laptopSize,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        text.compareUniversity,
                        style: theme.primaryTextTheme.displayLarge,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<CompareCubit, CompareState>(
                          builder: (context, state) {
                        if (state.firstUniversity != null) {
                          return UniversityCompared(
                            university: state.firstUniversity!,
                            isFirst: true,
                            onChange: () {},
                          );
                        }
                        return NoUniversityToCompare(
                          onCompare: () => _goCompare(context, id: "200"),
                        );
                      }),
                      const SizedBox(width: 8),
                      BlocBuilder<CompareCubit, CompareState>(
                        builder: (context, state) {
                          if (state.compareWith != null) {
                            return UniversityCompared(
                              university: state.compareWith!,
                              isFirst: false,
                              onChange: () => _resetUniversity(false),
                            );
                          }
                          return NoUniversityToCompare(
                            onCompare: () => _goCompare(context,
                                id: widget.universityId, withUniId: "200"),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const CriteriaItem(
                  criteria: Criteria.reputation,
                ),
                const CriteriaItem(
                  criteria: Criteria.competition,
                ),
                const CriteriaItem(
                  criteria: Criteria.internet,
                ),
                const CriteriaItem(
                  criteria: Criteria.location,
                ),
                const CriteriaItem(
                  criteria: Criteria.favorite,
                ),
                const CriteriaItem(
                  criteria: Criteria.infrastructure,
                ),
                const CriteriaItem(
                  criteria: Criteria.clubs,
                ),
                const CriteriaItem(
                  criteria: Criteria.food,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      onTap: () => _resetUniversity(true),
                      title: text.reset,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
