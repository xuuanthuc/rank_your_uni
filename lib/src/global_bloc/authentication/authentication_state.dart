part of 'authentication_bloc.dart';

enum AuthenticationAction { init, signIn, signUp, signOut, refreshToken }

enum AuthenticationStatus { unauthenticated, authenticated }

@injectable
class AuthenticationState extends Equatable {
  final bool? isLoading;
  final bool? isSuccess;
  final bool? isError;
  final AuthenticationStatus? status;
  final AuthenticationAction? action;

  const AuthenticationState({
    this.isLoading,
    this.isSuccess,
    this.status,
    this.action,
    this.isError,
  });

  AuthenticationState copyWith({
    bool? isLoading,
    AuthenticationStatus? status,
    AuthenticationAction? action,
    bool? isSuccess,
    bool? isError,
  }) {
    return AuthenticationState(
      isLoading: isLoading,
      status: status,
      isSuccess: isSuccess,
      action: action,
      isError: isError,
    );
  }

  @override
  List<Object?> get props => [
        isSuccess,
        status,
        isLoading,
        action,
        isError,
      ];
}
