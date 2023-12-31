import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:template/global/utilities/logger.dart';
import 'package:template/global/utilities/static_variable.dart';
import 'package:template/src/models/request/reset_password_request.dart';
import '../../../global/storage/storage_keys.dart';
import '../../../global/storage/storage_provider.dart';
import '../../models/request/sign_in_with_email_request.dart';
import '../../models/request/sign_up_with_email_request.dart';
import '../../repositories/auth_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  AuthenticationBloc(this._authRepository)
      : super(const AuthenticationState(
          status: AuthenticationStatus.unauthenticated,
          action: AuthenticationAction.init,
          isLoading: false,
          isSuccess: false,
        )) {
    on<OnSignInWithEmailEvent>(onSignInWithEmail);
    on<OnCheckToken>(onCheckToken);
    on<OnSignOutEvent>(onSignOut);
    on<OnSignUpWithEmailEvent>(onSignUpWithEmail);
    on<OnGoogleSignInEvent>(onGoogleSignIn);
    on<OnGoogleSignUpEvent>(onGoogleSignUp);
    on<OnForgotPasswordEvent>(onForgotPassword);
  }

  void onForgotPassword(
    OnForgotPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.forgotPassword,
      isSuccess: false,
      isLoading: true,
    ));
    try {
      final res = await _authRepository.onForgotPassword(event.email);
      if (res.isSuccess) {
        emit(state.copyWith(
          isSuccess: true,
          status: AuthenticationStatus.unauthenticated,
          action: AuthenticationAction.forgotPassword,
          isLoading: false,
        ));
      } else {
        emit(
          state.copyWith(
            isError: true,
            status: AuthenticationStatus.unauthenticated,
            action: AuthenticationAction.forgotPassword,
            isLoading: false,
            isSuccess: false,
            errorMessage: res.errorMessage,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(
        isError: true,
        status: AuthenticationStatus.unauthenticated,
        action: AuthenticationAction.forgotPassword,
        isLoading: false,
      ));
    }
  }

  void onCheckToken(
    OnCheckToken event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.refreshToken,
      isSuccess: false,
      isLoading: true,
    ));
    try {
      final res = await _authRepository.onRefreshToken();
      if (res.isSuccess) {
        emit(state.copyWith(
          isSuccess: true,
          status: AuthenticationStatus.authenticated,
          action: AuthenticationAction.refreshToken,
          isLoading: false,
        ));
      } else {
        emit(
          state.copyWith(
            isError: false,
            status: AuthenticationStatus.unauthenticated,
            action: AuthenticationAction.refreshToken,
            isLoading: false,
            isSuccess: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(
        isError: true,
        status: AuthenticationStatus.unauthenticated,
        action: AuthenticationAction.refreshToken,
        isLoading: false,
      ));
    }
  }

  void onSignInWithEmail(
    OnSignInWithEmailEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.signIn,
      isSuccess: false,
      isLoading: true,
    ));
    final res =
        await _authRepository.signInWithEmailAndPassword(event.signInRequest);
    if (res.isSuccess) {
      await StorageProvider.instance
          .save(StorageKeys.token, res.data["id_token"]);
      await StorageProvider.instance
          .save(StorageKeys.username, event.signInRequest.username);
      StaticVariable.tokenIsNotChecked = false;
      emit(state.copyWith(
        isSuccess: true,
        status: AuthenticationStatus.authenticated,
        action: AuthenticationAction.signIn,
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        isError: true,
        status: AuthenticationStatus.unauthenticated,
        action: AuthenticationAction.signIn,
        isLoading: false,
        errorMessage: res.errorMessage,
      ));
    }
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
    try {
      final isSuccess = await _authRepository.onSignOut();
      if (isSuccess) {
        emit(state.copyWith(
          isLoading: false,
          status: AuthenticationStatus.unauthenticated,
          action: AuthenticationAction.signOut,
          isSuccess: true,
        ));
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        status: AuthenticationStatus.authenticated,
        action: AuthenticationAction.signOut,
        isSuccess: false,
        isError: true,
      ));
    }
  }

  void onSignUpWithEmail(
    OnSignUpWithEmailEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      status: AuthenticationStatus.unauthenticated,
      action: AuthenticationAction.signUp,
      isLoading: true,
      isSuccess: false,
    ));
    final res =
        await _authRepository.signUpWithEmailAndPassword(event.signUpRequest);
    if (res.isSuccess) {
      await StorageProvider.instance.save(StorageKeys.token, res.data["token"]);
      await StorageProvider.instance
          .save(StorageKeys.username, event.signUpRequest.email);
      StaticVariable.tokenIsNotChecked = false;
      emit(state.copyWith(
        isLoading: false,
        status: AuthenticationStatus.authenticated,
        action: AuthenticationAction.signUp,
        isSuccess: true,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        status: AuthenticationStatus.unauthenticated,
        action: AuthenticationAction.signUp,
        isSuccess: false,
        errorMessage: res.errorMessage,
        isError: true,
      ));
    }
  }
}
