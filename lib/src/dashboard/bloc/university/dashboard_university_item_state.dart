part of 'dashboard_university_item_cubit.dart';

enum DashboardUniversityStatus { loading, success, error }

@immutable
class DashboardUniversityItemState extends Equatable {
  final DashboardUniversityStatus? status;
  final String? errorMessage;
  final University? university;

  const DashboardUniversityItemState({
    this.status,
    this.errorMessage,
    this.university,
  });

  DashboardUniversityItemState copyWith(
      {DashboardUniversityStatus? status,
      String? errorMessage,
      bool? isHovering,
      University? university}) {
    return DashboardUniversityItemState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      university: university ?? this.university,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        university,
      ];
}
