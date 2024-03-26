part of 'dashboard_cubit.dart';

enum DashboardStatus {
  success,
  loading,
  error,
}

enum DashboardPages { university, user, report, contact }

@immutable
class DashboardState extends Equatable {
  final DashboardPages? page;
  final DashboardStatus? status;
  final List<University>? universities;
  final List<Contact>? contacts;
  final List<Profile>? accounts;

  const DashboardState({
    this.status,
    this.page,
    this.universities,
    this.contacts,
    this.accounts,
  });

  DashboardState copyWith({
    DashboardPages? page,
    DashboardStatus? status,
    List<University>? universities,
    List<Contact>? contacts,
    List<Profile>? accounts,
  }) {
    return DashboardState(
      status: status ?? this.status,
      page: page ?? this.page,
      universities: universities ?? this.universities,
      contacts: contacts ?? this.contacts,
      accounts: accounts ?? this.accounts,
    );
  }

  @override
  List<Object?> get props => [
        page,
        status,
        universities,
        contacts,
        accounts,
      ];
}
