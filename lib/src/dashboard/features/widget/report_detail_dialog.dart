import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/global/style/styles.dart';
import 'package:template/src/dashboard/bloc/report/dashboard_report_item_cubit.dart';
import 'package:template/src/models/response/report.dart';
import 'package:template/src/models/response/review.dart';
import 'package:template/src/screens/detail/widgets/university_reviews.dart';
import 'package:template/src/screens/widgets/primary_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../global/utilities/toast.dart';
import '../../../screens/widgets/loading_primary_button.dart';

class ReportDetailDialog extends StatefulWidget {
  final Report report;

  const ReportDetailDialog({
    super.key,
    required this.report,
  });

  @override
  State<ReportDetailDialog> createState() => _ReportDetailDialogState();
}

class _ReportDetailDialogState extends State<ReportDetailDialog> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardReportItemCubit>().getReport(widget.report);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return PrimaryDialog(
      maxWidth: Public.desktopSize,
      child: BlocListener<DashboardReportItemCubit, DashboardReportItemState>(
        listener: (context, state) {
          if (state.status == DashboardReportStatus.success) {
            appToast(context,
                message: AppLocalizations.of(context)!.updateSuccess,
                type: ToastType.success);
            context.pop(state.report);
          } else if (state.status == DashboardReportStatus.error) {
            appToast(
              context,
              message: AppLocalizations.of(context)!.somethingWrong,
              subMessage: AppLocalizations.of(context)!.tryAgainLater,
            );
          }
        },
        child: BlocBuilder<DashboardReportItemCubit, DashboardReportItemState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text.reason,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  state.report?.reportReason ?? "",
                  style: theme.primaryTextTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                Text(
                  text.universityName,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () async {
                    final id = state.report?.review?.schoolId;
                    if (id == null) return;
                    if (!await launchUrl(
                        Uri.parse('https://rankyouruni.com/university/$id'))) {
                      throw Exception('Could not launch');
                    }
                  },
                  child: Text(
                    state.report?.review?.schoolName ?? "",
                    style: theme.primaryTextTheme.titleLarge?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  text.review,
                  style: theme.primaryTextTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                ReviewItem(
                  review: state.report?.review ?? Review(-1),
                  onUpdateReviewIndex: (review) {},
                  isPreview: true,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    LoadingPrimaryButton<DashboardReportItemCubit,
                        DashboardReportItemState>(
                      buttonWidth: 200,
                      onTap: () {
                        //delete report
                        context.read<DashboardReportItemCubit>().deleteReport();
                      },
                      label: text.acceptReview,
                      updateLoading: (state) {
                        return (state).status == DashboardReportStatus.loading;
                      },
                    ),
                    const SizedBox(width: 20),
                    LoadingPrimaryButton<DashboardReportItemCubit,
                        DashboardReportItemState>(
                      buttonWidth: 200,
                      onTap: () {
                        final id = state.report?.review?.id;
                        if (id == null) return;
                        context
                            .read<DashboardReportItemCubit>()
                            .deleteReview(id);
                      },
                      label: text.deleteReview,
                      updateLoading: (state) {
                        return (state).status == DashboardReportStatus.loading;
                      },
                      updateColor: (state) {
                        return AppColors.error;
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
