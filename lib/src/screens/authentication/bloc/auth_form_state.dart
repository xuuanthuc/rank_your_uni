part of 'auth_form_cubit.dart';

@immutable
class AuthFormState extends Equatable {
  final String? error;

  const AuthFormState({this.error});

  AuthFormState copyWith({String? error}) {
    return AuthFormState(error: error);
  }

  @override
  List<Object?> get props => [error];
}
