import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(const AuthenticationState(
          status: AuthenticationStatus.none,
          isAuthenticated: false,
        )) {
    on<OnSignInEvent>(onSignIn);
    on<OnSignOutEvent>(onSignOut);
  }

  void onSignIn(OnSignInEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));
    await Future.delayed(Duration(seconds: 1));
    emit(state.copyWith(
      isAuthenticated: true,
      status: AuthenticationStatus.success,
    ));
  }

  void onSignOut(OnSignOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));
    await Future.delayed(Duration(seconds: 1));
    emit(state.copyWith(
      isAuthenticated: false,
      status: AuthenticationStatus.success,
    ));
  }
}
