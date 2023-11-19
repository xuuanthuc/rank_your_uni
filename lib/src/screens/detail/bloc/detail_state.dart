part of 'detail_cubit.dart';

enum DetailStatus { loading, success, error }

@immutable
class DetailState extends Equatable {
  final DetailStatus? status;
  final University? university;

  const DetailState({
    this.status,
    this.university,
  });

  DetailState copyWith({
    DetailStatus? status,
    University? university,
  }) {
    return DetailState(
      status: status ?? this.status,
      university: university ?? this.university,
    );
  }

  @override
  List<Object?> get props => [
        university,
        status,
      ];
}
