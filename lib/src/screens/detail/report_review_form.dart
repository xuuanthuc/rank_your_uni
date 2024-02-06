import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/models/response/review.dart';
import 'package:template/src/screens/detail/bloc/report_cubit.dart';
import 'package:template/src/screens/widgets/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/style/styles.dart';
import '../../../global/utilities/toast.dart';
import '../widgets/primary_dialog.dart';
import '../widgets/loading_primary_button.dart';

class ReportReviewForm extends StatefulWidget {
  final Review review;

  const ReportReviewForm({
    super.key,
    required this.review,
  });

  @override
  State<ReportReviewForm> createState() => _ReportReviewFormState();
}

class _ReportReviewFormState extends State<ReportReviewForm> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = AppLocalizations.of(context)!;
    return BlocListener<ReportCubit, ReportState>(
      listener: (context, state) {
        if (state.status == ReportStatus.success) {
          appToast(context,
              message: AppLocalizations.of(context)!.reportSuccess,
              subMessage: AppLocalizations.of(context)!.subtitleReportSuccess,
              type: ToastType.success);
          context.pop();
        } else if (state.status == ReportStatus.error) {
          appToast(
            context,
            message: AppLocalizations.of(context)!.somethingWrong,
            subMessage: AppLocalizations.of(context)!.tryAgainLater,
          );
        }
      },
      child: PrimaryDialog(
        child: Column(
          children: [
            Text(
              text.reportReview,
              style: theme.primaryTextTheme.labelLarge,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.level4.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text.youAreReportingReview,
                            style: theme.primaryTextTheme.labelLarge,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.review.content ?? '',
                            style: theme.primaryTextTheme.bodyMedium,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            text.whatIsMatter,
                            style: theme.primaryTextTheme.labelLarge,
                          ),
                          const SizedBox(height: 6),
                          MarkdownBody(
                            data: 'Nếu bạn cho rằng nhận xét này không phù hợp với [hướng dẫn sử dụng trang](https://rankyouruni.com/guidelines) chúng mình, hãy báo cáo nhận xét đó và cho chúng mình biết lý do.',
                            selectable: true,
                            onTapLink: (t, u, c) async {
                              if (u != null) {
                                if (!await launchUrl(Uri.parse(u))) {
                                  throw Exception('Could not launch $u');
                                }
                              }
                            },
                            styleSheet: MarkdownStyleSheet(
                              a: theme.primaryTextTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.info,
                              ),
                              p: theme.primaryTextTheme.bodyMedium,
                            ),
                          ),
                          // Text(
                          //   text.whatIsMatterDescription,
                          //   style: theme.primaryTextTheme.bodyMedium,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              maxLines: 4,
              maxLength: 250,
              controller: _editingController,
              onChanged: (value) {
                context
                    .read<ReportCubit>()
                    .updateReason(_editingController.text);
              },
              decoration: InputDecoration(
                hintText: text.reportContent,
                hintStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
                  color: AppColors.textGrey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 1)),
              ),
            ),
            const SizedBox(height: 30),
            LoadingPrimaryButton<ReportCubit, ReportState>(
              onTap: () {
                if (_editingController.text.trim().isNotEmpty) {
                  context.read<ReportCubit>().reportReview(
                      widget.review, _editingController.text);
                }
              },
              label: text.report,
              buttonWidth: 250,
              updateLoading: (state) {
                return (state).status == ReportStatus.loading;
              },
              updateColor: (state) {
                return _editingController.text.trim().isEmpty
                    ? AppColors.grey
                    : null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
