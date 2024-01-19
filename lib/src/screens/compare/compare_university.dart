import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/enum/criteria.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/widgets/base_scaffold.dart';
import 'package:template/src/screens/widgets/bloc/autocompletion_cubit.dart';
import '../../../global/routes/route_keys.dart';
import '../widgets/primary_button.dart';
import 'bloc/compare_cubit.dart';
import 'widgets/compare_criteria.dart';
import 'widgets/no_uni_for_compare.dart';
import 'widgets/uni_for_compare.dart';

class CompareScreen extends StatelessWidget {
  final String? universityId;
  final String? compareWithUniversityId;
  final University? universityInitial;

  const CompareScreen({
    super.key,
    this.universityId,
    this.compareWithUniversityId,
    this.universityInitial,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<CompareCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<AutocompletionCubit>(),
        ),
      ],
      child: CompareView(
        universityId: universityId,
        compareWithUniversityId: compareWithUniversityId,
        universityInitial: universityInitial,
      ),
    );
  }
}

class CompareView extends StatefulWidget {
  final String? universityId;
  final String? compareWithUniversityId;
  final University? universityInitial;

  const CompareView({
    super.key,
    required this.universityId,
    this.compareWithUniversityId,
    this.universityInitial,
  });

  @override
  State<CompareView> createState() => _CompareViewState();
}

class _CompareViewState extends State<CompareView> {
  @override
  void initState() {
    super.initState();
    if (widget.universityId != null) {
      context.read<CompareCubit>().initFirstUniversity(
          int.tryParse(widget.universityId!) ?? -1, widget.universityInitial);
    }
    if (widget.compareWithUniversityId != null) {
      context
          .read<CompareCubit>()
          .compareWith(int.tryParse(widget.compareWithUniversityId!) ?? -1);
    }
  }

  void _goCompare(BuildContext context,
      {String? id, String? withUniId, University? university}) {
    if (id != null) {
      Map<String, String> param = {
        "id": id,
      };
      String route = RouteKey.compare;
      if (withUniId != null) {
        param = {
          "id": id,
          "withUniId": withUniId,
        };
        route = RouteKey.compareWith;
      }
      context.goNamed(route, pathParameters: param, extra: university);
    }
  }

  void _resetUniversity(bool resetAll, {String? id, University? university}) {
    if (resetAll) {
      context.goNamed(
        RouteKey.reset,
      );
    } else {
      if (id != null) {
        context.goNamed(RouteKey.compare,
            pathParameters: {
              "id": id,
            },
            extra: university);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AppScaffold(
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
                      onCompare: (id) => _goCompare(
                        context,
                        id: id.toString(),
                      ),
                    );
                  }),
              const SizedBox(width: 8),
              BlocBuilder<CompareCubit, CompareState>(
                builder: (context, state) {
                  if (state.compareWith != null) {
                    return UniversityCompared(
                      university: state.compareWith!,
                      isFirst: false,
                      onChange: () => _resetUniversity(
                        false,
                        id: state.firstUniversity?.id.toString(),
                        university: state.firstUniversity,
                      ),
                    );
                  }
                  return NoUniversityToCompare(
                    onCompare: (id) {
                      if (state.firstUniversity == null) {
                        _goCompare(
                          context,
                          id: id.toString(),
                        );
                      } else {
                        _goCompare(
                          context,
                          id: widget.universityId,
                          university: widget.universityInitial,
                          withUniId: id.toString(),
                        );
                      }
                    },
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
            PrimaryButton(
              onTap: () => _resetUniversity(true),
              title: text.reset,
            ),
          ],
        ),
      ],
    );
  }
}
