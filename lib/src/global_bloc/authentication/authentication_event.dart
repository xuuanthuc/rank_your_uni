part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class OnSignInWithEmailEvent extends AuthenticationEvent {
  final SignInWithEmailRaw signInRequest;

  const OnSignInWithEmailEvent(
    this.signInRequest,
  );

  @override
  List<Object?> get props => [signInRequest];
}

class OnSignOutEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OnCheckToken extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OnSignUpWithEmailEvent extends AuthenticationEvent {
  final SignUpWithEmailRaw signUpRequest;

  const OnSignUpWithEmailEvent(this.signUpRequest);

  @override
  List<Object?> get props => [
        signUpRequest,
      ];
}

class OnGoogleSignInEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OnGoogleSignUpEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OnForgotPasswordEvent extends AuthenticationEvent {
  final String email;

  const OnForgotPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}
