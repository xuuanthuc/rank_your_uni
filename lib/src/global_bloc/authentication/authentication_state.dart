part of 'authentication_bloc.dart';

enum AuthenticationAction { init, signIn, signUp, signOut }

enum AuthenticationStatus { unauthenticated, authenticated }

@injectable
class AuthenticationState extends Equatable {
  final bool? isLoading;
  final bool? isSuccess;
  final AuthenticationStatus? status;
  final AuthenticationAction? action;

  const AuthenticationState({
    this.isLoading,
    this.isSuccess,
    this.status,
    this.action,
  });

  AuthenticationState copyWith({
    bool? isLoading,
    AuthenticationStatus? status,
    AuthenticationAction? action,
    bool? isSuccess,
  }) {
    return AuthenticationState(
        isLoading: isLoading,
        status: status,
        isSuccess: isSuccess,
        action: action);
  }

  @override
  List<Object?> get props => [
        isSuccess,
        status,
        isLoading,
        action,
      ];
}
