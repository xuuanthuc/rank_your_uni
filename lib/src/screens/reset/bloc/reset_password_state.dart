part of 'reset_password_cubit.dart';

enum ResetStatus {
  loading,
  success,
  error,
}

@immutable
class ResetPasswordState extends Equatable {
  final ResetStatus? status;
  final String? errorMessage;

  const ResetPasswordState({
    this.status,
    this.errorMessage,
  });

  ResetPasswordState copyWith({
    ResetStatus? status,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
