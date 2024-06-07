part of 'authentication_bloc.dart';

enum AuthenticationAction {
  init,
  signIn,
  signUp,
  signOut,
  refreshToken,
  forgotPassword,
}

enum AuthenticationStatus {
  unauthenticated,
  authenticated,
}

@injectable
class AuthenticationState extends Equatable {
  final bool? isLoading;
  final bool? isSuccess;
  final bool? isError;
  final String? errorMessage;
  final AuthenticationStatus? status;
  final AuthenticationAction? action;
  final Profile? profile;

  const AuthenticationState({
    this.isLoading,
    this.isSuccess,
    this.status,
    this.action,
    this.isError,
    this.errorMessage,
    this.profile,
  });

  AuthenticationState copyWith({
    bool? isLoading,
    AuthenticationStatus? status,
    AuthenticationAction? action,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    Profile? profile,
  }) {
    return AuthenticationState(
      isLoading: isLoading,
      isSuccess: isSuccess,
      isError: isError,
      status: status,
      action: action,
      errorMessage: errorMessage,
      profile: profile,
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
        profile,
      ];
}
