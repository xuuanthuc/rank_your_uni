part of 'dashboard_professor_item_cubit.dart';

enum DashboardProfessorStatus { loading, success, error }

@immutable
class DashboardProfessorItemState extends Equatable {
  final DashboardProfessorStatus? status;
  final String? errorMessage;
  final Professor? professor;

  const DashboardProfessorItemState({
    this.status,
    this.errorMessage,
    this.professor,
  });

  DashboardProfessorItemState copyWith(
      {DashboardProfessorStatus? status,
      String? errorMessage,
      bool? isHovering,
      Professor? professor}) {
    return DashboardProfessorItemState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      professor: professor ?? this.professor,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        professor,
      ];
}
