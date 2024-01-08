part of 'dashboard_cubit.dart';

enum DashboardStatus {
  success,
  loading,
  error,
}

enum DashboardPages { university, user, report }

@immutable
class DashboardState extends Equatable {
  final DashboardPages? page;
  final DashboardStatus? status;
  final List<University>? universities;

  const DashboardState({
    this.status,
    this.page,
    this.universities,
  });

  DashboardState copyWith({
    DashboardPages? page,
    DashboardStatus? status,
    List<University>? universities,
  }) {
    return DashboardState(
      status: status ?? this.status,
      page: page ?? this.page,
      universities: universities ?? this.universities,
    );
  }

  @override
  List<Object?> get props => [
        page,
        status,
        universities,
      ];
}
