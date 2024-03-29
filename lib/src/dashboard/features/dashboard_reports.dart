import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/report/dashboard_report_item_cubit.dart';
import 'package:template/src/dashboard/features/widget/dashboard_title.dart';
import 'package:template/src/dashboard/features/widget/header_line.dart';
import 'package:template/src/dashboard/features/widget/report_detail_dialog.dart';
import 'package:template/src/di/dependencies.dart';
import 'package:template/src/models/response/report.dart';
import 'package:template/src/screens/widgets/loading.dart';
import '../../screens/detail/bloc/review_item_cubit.dart';
import '../bloc/dashboard_cubit.dart';

class DashboardReports extends StatelessWidget {
  const DashboardReports({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardTitle(title: text.report),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text.reason,
                  style: theme.primaryTextTheme.titleLarge,
                ),
              ),
              const HeaderLine(),
              Text(
                text.status,
                textAlign: TextAlign.center,
                style: theme.primaryTextTheme.bodyMedium,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state.status == DashboardStatus.loading) {
              return Expanded(
                child: Center(
                  child: PrimaryCircularLoading(
                    state.status == DashboardStatus.loading,
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) =>
                    Container(
                      height: 1,
                      color: AppColors.primaryShadow,
                    ),
                itemBuilder: (context, index) {
                  final report = (state.reports ?? [])[index];
                  return BlocProvider(
                    create: (context) => getIt.get<DashboardReportItemCubit>(),
                    child: ItemReport(report: report),
                  );
                },
                itemCount: state.reports?.length ?? 0,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ItemReport extends StatefulWidget {
  final Report report;

  const ItemReport({
    super.key,
    required this.report,
  });

  @override
  State<ItemReport> createState() => _ItemReportState();
}

class _ItemReportState extends State<ItemReport> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardReportItemCubit>().getReport(widget.report);
  }

  void _showReportDetailDialog(BuildContext context,
      Report report,) {
    showDialog(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt.get<DashboardReportItemCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt.get<ReviewItemCubit>(),
            ),
          ],
          child: ReportDetailDialog(report: report),
        );
      },
    ).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocBuilder<DashboardReportItemCubit, DashboardReportItemState>(
      builder: (context, state) {
        if (state.report == null) return Container();
        return InkWell(
          onTap: () => _showReportDetailDialog(context, state.report!),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const SizedBox(height: 34),
                SizedBox(
                  width: 50,
                  child: Text(
                    state.report!.id.toString(),
                    style: theme.primaryTextTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    state.report!.reportReason ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
    ;
  }
}
