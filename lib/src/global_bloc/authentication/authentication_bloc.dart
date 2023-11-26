import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:template/global/utilities/logger.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(const AuthenticationState(
          status: AuthenticationStatus.unauthenticated,
          action: AuthenticationAction.init,
          isLoading: false,
          isSuccess: false,
        )) {
    on<OnSignInEvent>(onSignIn);
    on<OnSignOutEvent>(onSignOut);
    on<OnSignUpEvent>(onSignUp);
    on<OnCompleteSignUpEvent>(onComplete);
    on<OnGoogleSignInEvent>(onGoogleSignIn);
    on<OnGoogleSignUpEvent>(onGoogleSignUp);
  }

  void onSignIn(
    OnSignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.signIn,
      isSuccess: false,
      isLoading: true,
    ));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
      isSuccess: true,
      status: AuthenticationStatus.authenticated,
      action: AuthenticationAction.signIn,
      isLoading: false,
    ));
  }

  void onGoogleSignIn(
    OnGoogleSignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      emit(state.copyWith(
        status: AuthenticationStatus.unauthenticated,
        action: AuthenticationAction.signIn,
        isSuccess: false,
        isLoading: true,
      ));
      final auth = await googleSignIn.signIn();
      if (auth != null) {
        LoggerUtils.i(
            await auth.authentication.then((value) => value.accessToken));
        emit(state.copyWith(
          isSuccess: true,
          status: AuthenticationStatus.authenticated,
          action: AuthenticationAction.signIn,
          isLoading: false,
        ));
        googleSignIn.disconnect();
      } else {
        emit(state.copyWith(
          isSuccess: false,
          status: AuthenticationStatus.unauthenticated,
          action: AuthenticationAction.signIn,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isSuccess: false,
        status: AuthenticationStatus.unauthenticated,
        action: AuthenticationAction.signIn,
        isLoading: false,
      ));
    }
  }

  void onGoogleSignUp(
    OnGoogleSignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    // emit(state.copyWith(
    //   status: AuthenticationStatus.unauthenticated,
    //   action: AuthenticationAction.signIn,
    //   isSuccess: false,
    //   isLoading: true,
    // ));
    // await Future.delayed(const Duration(seconds: 1));
    // emit(state.copyWith(
    //   isSuccess: true,
    //   status: AuthenticationStatus.authenticated,
    //   action: AuthenticationAction.signIn,
    //   isLoading: false,
    // ));
  }

  void onComplete(
    OnCompleteSignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state.action == AuthenticationAction.signUp) {
      emit(state.copyWith(
        isSuccess: true,
        status: AuthenticationStatus.authenticated,
        action: AuthenticationAction.signIn,
        isLoading: false,
      ));
    }
  }

  void onSignOut(
    OnSignOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthenticationStatus.authenticated,
      action: AuthenticationAction.signOut,
      isLoading: true,
      isSuccess: false,
    ));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
      isLoading: false,
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.signOut,
      isSuccess: true,
    ));
  }

  void onSignUp(
    OnSignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.signUp,
      isLoading: true,
      isSuccess: false,
    ));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
      isLoading: false,
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.signUp,
      isSuccess: true,
    ));
  }
}
