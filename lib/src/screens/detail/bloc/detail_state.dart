part of 'detail_cubit.dart';

enum DetailStatus { loading, success, error }

enum SortType { date, like }

@immutable
class DetailState extends Equatable {
  final DetailStatus? status;
  final University? university;
  final SortType? sortType;

  const DetailState({
    this.status,
    this.university,
    this.sortType,
  });

  DetailState copyWith({
    DetailStatus? status,
    University? university,
    SortType? sortType,
  }) {
    return DetailState(
      status: status ?? this.status,
      university: university ?? this.university,
      sortType: sortType ?? this.sortType,
    );
  }

  @override
  List<Object?> get props => [
        university,
        status,
        sortType,
      ];
}
