part of 'detail_professor_cubit.dart';

enum DetailStatus { loading, success, error }

enum SortType { date, like }

@immutable
class DetailProfessorState extends Equatable {
  final DetailStatus? status;
  final Professor? professor;
  final SortType? sortType;
  final Profile? userAuthenticated;

  const DetailProfessorState(
      {this.status, this.professor, this.sortType, this.userAuthenticated});

  DetailProfessorState copyWith({
    DetailStatus? status,
    Professor? professor,
    SortType? sortType,
    Profile? userAuthenticated,
  }) {
    return DetailProfessorState(
      status: status ?? this.status,
      professor: professor ?? this.professor,
      sortType: sortType ?? this.sortType,
      userAuthenticated: userAuthenticated ?? this.userAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        professor,
        status,
        sortType,
        userAuthenticated,
      ];
}
