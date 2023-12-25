part of 'authentication_bloc.dart';

enum AuthenticationAction { init, signIn, signUp, signOut, refreshToken }

enum AuthenticationStatus { unauthenticated, authenticated }

@injectable
class AuthenticationState extends Equatable {
  final bool? isLoading;
  final bool? isSuccess;
  final bool? isError;
  final String? errorMessage;
  final AuthenticationStatus? status;
  final AuthenticationAction? action;
  final Profile? profileAuthenticated;

  const AuthenticationState({
    this.isLoading,
    this.isSuccess,
    this.status,
    this.action,
    this.isError,
    this.errorMessage,
    this.profileAuthenticated,
  });

  AuthenticationState copyWith({
    bool? isLoading,
    AuthenticationStatus? status,
    AuthenticationAction? action,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    Profile? profileAuthenticated,
  }) {
    return AuthenticationState(
      isLoading: isLoading,
      isSuccess: isSuccess,
      isError: isError,
      status: status,
      action: action,
      errorMessage: errorMessage,
      profileAuthenticated: profileAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isError,
        status,
        action,
        errorMessage,
        profileAuthenticated,
      ];
}
