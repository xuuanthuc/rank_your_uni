part of 'dashboard_cubit.dart';

enum DashboardStatus {
  success,
  loading,
  error,
}

enum DashboardPages { university, user, report, contact, professor }

@immutable
class DashboardState extends Equatable {
  final DashboardPages? page;
  final DashboardStatus? status;
  final List<University>? universities;
  final List<Professor>? professors;
  final List<Contact>? contacts;
  final List<Profile>? accounts;
  final List<Report>? reports;

  const DashboardState({
    this.status,
    this.page,
    this.universities,
    this.contacts,
    this.accounts,
    this.reports,
    this.professors,
  });

  DashboardState copyWith({
    DashboardPages? page,
    DashboardStatus? status,
    List<University>? universities,
    List<Contact>? contacts,
    List<Profile>? accounts,
    List<Report>? reports,
    List<Professor>? professors,
  }) {
    return DashboardState(
      status: status ?? this.status,
      page: page ?? this.page,
      universities: universities ?? this.universities,
      contacts: contacts ?? this.contacts,
      accounts: accounts ?? this.accounts,
      professors: professors ?? this.professors,
      reports: reports ?? this.reports,
    );
  }

  @override
  List<Object?> get props => [
        page,
        status,
        universities,
        contacts,
        accounts,
        reports,
        professors,
      ];
}
