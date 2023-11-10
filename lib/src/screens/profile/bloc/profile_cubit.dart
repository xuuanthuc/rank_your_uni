import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/screens/appbar/widgets/user_button.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void onPageChange(QuickMenu menu) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(page: menu, status: ProfileStatus.success));
  }
}
