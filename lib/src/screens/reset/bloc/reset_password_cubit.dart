import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:template/src/models/request/reset_password_request.dart';

import '../../../repositories/auth_repository.dart';

part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(this._authRepository) : super(const ResetPasswordState());

  void onResetPassword(ResetPasswordRaw reset) async {
    emit(state.copyWith(status: ResetStatus.loading));
    try {
      final res = await _authRepository.onResetPassword(reset);
      if (res.isSuccess) {
        emit(state.copyWith(status: ResetStatus.success));
      } else {
        emit(
          state.copyWith(status: ResetStatus.error),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: ResetStatus.error));
    }
  }

  void showError(String errorMessage) async {
    emit(state.copyWith(errorMessage: errorMessage));
  }
}
