import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/profile.dart';
import 'package:template/src/models/response/review.dart';
import 'package:template/src/repositories/user_repository.dart';
import 'package:template/src/screens/appbar/widgets/user_button.dart';
import '../../../../global/storage/storage_keys.dart';
import '../../../../global/storage/storage_provider.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit(this._userRepository) : super(const ProfileState());

  void getProfile() {}

  void onPageChange(QuickMenu menu) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    emit(state.copyWith(page: menu, status: ProfileStatus.success));
  }

  void getMyReview(BuildContext context) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final userJson = await StorageProvider.instance.get(StorageKeys.user);
    if (userJson == null) return;
    final user = Profile.fromJson(jsonDecode(userJson));
    if (user.id == null) return;
    if ((state.reviews ?? []).isNotEmpty) {
      emit(state.copyWith(
        status: ProfileStatus.success,
        userAuthenticated: user,
      ));
      return;
    }
    final res = await _userRepository.getMyReviews(user.id.toString());
    if (res.isSuccess) {
      emit(state.copyWith(
        status: ProfileStatus.success,
        reviews: res.data,
        userAuthenticated: user,
      ));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }
}
