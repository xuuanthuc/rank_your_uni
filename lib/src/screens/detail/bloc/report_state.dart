part of 'report_cubit.dart';

enum ReportStatus {
  loading,
  success,
  error,
}

@immutable
class ReportState extends Equatable {
  final ReportStatus? status;
  final String? reason;

  const ReportState({this.status, this.reason});

  ReportState copyWith({ReportStatus? status, String? reason}) {
    return ReportState(
      status: status ?? this.status,
      reason: reason ?? this.reason,
    );
  }

  @override
  List<Object?> get props => [
        status,
        reason,
      ];
}
