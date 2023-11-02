part of 'authentication_bloc.dart';

enum AuthenticationStatus { none, loading, success, error }

@injectable
class AuthenticationState extends Equatable {
  final bool? isAuthenticated;
  final AuthenticationStatus? status;

  const AuthenticationState({
    this.isAuthenticated,
    this.status,
  });

  AuthenticationState copyWith({
    bool? isAuthenticated,
    AuthenticationStatus? status,
  }) {
    return AuthenticationState(
      isAuthenticated: isAuthenticated,
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        isAuthenticated,
        status,
      ];
}
