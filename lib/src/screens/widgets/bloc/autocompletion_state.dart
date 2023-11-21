part of 'autocompletion_cubit.dart';

enum AutoStatus {
  loading,
  success,
  error,
  cancel,
}

@immutable
class AutocompletionState extends Equatable {
  final AutoStatus? status;
  final List<University>? universities;

  const AutocompletionState({this.status, this.universities});

  AutocompletionState copyWith(
      {AutoStatus? status, List<University>? universities}) {
    return AutocompletionState(
      status: status ?? this.status,
      universities: universities ?? this.universities,
    );
  }

  @override
  List<Object?> get props => [universities];
}
