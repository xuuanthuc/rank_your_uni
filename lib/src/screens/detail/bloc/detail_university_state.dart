part of 'detail_university_cubit.dart';

enum DetailStatus { loading, success, error }


@immutable
class DetailUniversityState extends Equatable {
  final DetailStatus? status;
  final University? university;
  final SortType? sortType;
  final Profile? userAuthenticated;

  const DetailUniversityState(
      {this.status, this.university, this.sortType, this.userAuthenticated});

  DetailUniversityState copyWith({
    DetailStatus? status,
    University? university,
    SortType? sortType,
    Profile? userAuthenticated,
  }) {
    return DetailUniversityState(
      status: status ?? this.status,
      university: university ?? this.university,
      sortType: sortType ?? this.sortType,
      userAuthenticated: userAuthenticated ?? this.userAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        university,
        status,
        sortType,
        userAuthenticated,
      ];
}
