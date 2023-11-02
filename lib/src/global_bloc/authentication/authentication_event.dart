part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class OnSignInEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}


class OnSignOutEvent extends AuthenticationEvent{
  @override
  List<Object?> get props => [];
}