part of 'detail_cubit.dart';

enum DetailStatus { loading, success, error }

enum SortType { date, like }

@immutable
class DetailState extends Equatable {
  final DetailStatus? status;
  final University? university;
  final SortType? sortType;
  final Profile? userAuthenticated;

  const DetailState(
      {this.status, this.university, this.sortType, this.userAuthenticated});

  DetailState copyWith({
    DetailStatus? status,
    University? university,
    SortType? sortType,
    Profile? userAuthenticated,
  }) {
    return DetailState(
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
