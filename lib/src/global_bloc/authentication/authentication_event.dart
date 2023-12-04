part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class OnSignInEvent extends AuthenticationEvent {
  final SignInWithEmailRaw signInRequest;

  const OnSignInEvent(
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

class OnSignUpEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OnCompleteSignUpEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OnGoogleSignInEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class OnGoogleSignUpEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
