part of 'compare_cubit.dart';

enum CompareStatus { loading, success, error }

@immutable
class CompareState extends Equatable {
  final CompareStatus? status;
  final University? compareWith;
  final University? firstUniversity;

  const CompareState({
    this.status,
    this.compareWith,
    this.firstUniversity,
  });

  CompareState copyWith({
    CompareStatus? status,
    University? compareWith,
    University? firstUniversity,
  }) {
    return CompareState(
      status: status ?? this.status,
      compareWith: compareWith,
      firstUniversity: firstUniversity,
    );
  }

  @override
  List<Object?> get props => [
        status,
        compareWith,
        firstUniversity,
      ];
}
