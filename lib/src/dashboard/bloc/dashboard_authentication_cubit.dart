import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_authentication_state.dart';

@injectable
class DashboardAuthenticationCubit extends Cubit<DashboardAuthenticationState> {
  DashboardAuthenticationCubit() : super(const DashboardAuthenticationState());

  void onHover(bool isHovering){
    emit(state.copyWith(isHovering: isHovering));
  }
}
