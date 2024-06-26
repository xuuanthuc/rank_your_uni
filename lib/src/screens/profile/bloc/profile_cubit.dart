import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/professor_review.dart';
import 'package:template/src/models/response/profile.dart';
import 'package:template/src/models/response/university_review.dart';
import 'package:template/src/repositories/user_repository.dart';
import 'package:template/src/screens/appbar/widgets/user_button.dart';
import '../../../../global/storage/storage_keys.dart';
import '../../../../global/storage/storage_provider.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit(this._userRepository) : super(const ProfileState());

  void checkProfile(Profile? profile) async {
    if (profile == null) return;
    emit(state.copyWith(
      canEdit: profile.provider == UserProvider.ryu,
    ));
  }

  void onPageChange(QuickMenu menu) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    emit(state.copyWith(page: menu, status: ProfileStatus.success));
  }

  void getMyUniversityReview(BuildContext context) async {
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
    final res = await _userRepository.getMyUniversityReviews(user.id.toString());
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

  void getMyProfessorReview(BuildContext context) async {
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
    final res = await _userRepository.getMyProfessorReviews(user.id.toString());
    if (res.isSuccess) {
      emit(state.copyWith(
        status: ProfileStatus.success,
        professorReviews: res.data,
        userAuthenticated: user,
      ));
    } else {
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }
}
