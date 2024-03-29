part of 'dashboard_report_item_cubit.dart';

enum DashboardReportStatus { loading, success, error }

@immutable
class DashboardReportItemState extends Equatable {
  final DashboardReportStatus? status;
  final Report? report;

  const DashboardReportItemState({
    this.status,
    this.report,
  });

  DashboardReportItemState copyWith({
    DashboardReportStatus? status,
    Report? report,
  }) {
    return DashboardReportItemState(
      status: status ?? this.status,
      report: report ?? this.report,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
