import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/global/utilities/static_variable.dart';
import 'package:template/src/models/request/sign_in_with_email_request.dart';
import 'package:video_player/video_player.dart';

import '../../repositories/dashboard_repository.dart';

part 'dashboard_authentication_state.dart';

@injectable
class DashboardAuthenticationCubit extends Cubit<DashboardAuthenticationState> {
  final DashboardRepository _adminRepository;

  DashboardAuthenticationCubit(this._adminRepository)
      : super(const DashboardAuthenticationState());

  void onHover(bool isHovering) {
    emit(state.copyWith(isHovering: isHovering));
  }

  void signInDashboard(SignInWithEmailRaw raw) async {
    emit(state.copyWith(status: DashboardAuthenticationStatus.loading));
    final res = await _adminRepository.signInWithEmailAndPassword(raw);
    if (res.isSuccess) {
      StaticVariable.dashboardToken = res.data["id_token"];
      emit(state.copyWith(status: DashboardAuthenticationStatus.success));
    } else {
      emit(state.copyWith(
        status: DashboardAuthenticationStatus.error,
        errorMessage: res.errorMessage,
      ));
    }
  }
}
