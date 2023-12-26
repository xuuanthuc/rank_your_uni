import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/password_request.dart';
import 'package:template/src/models/request/profile_request.dart';

import '../../../global/storage/storage_keys.dart';
import '../../../global/storage/storage_provider.dart';
import '../../models/response/profile.dart';
import '../../repositories/user_repository.dart';

part 'app_settings_event.dart';

part 'app_settings_state.dart';

@injectable
class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final UserRepository _userRepository;

  AppSettingsBloc(this._userRepository) : super(const AppSettingsState()) {
    on<UpdateUserProfileEvent>(_updateUserProfile);
    on<UpdatePasswordEvent>(_updatePassword);
    on<GetUserProfileEvent>(_getUserProfile);
  }

  void _getUserProfile(
    GetUserProfileEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    final username = await StorageProvider.instance.get(StorageKeys.username);
    if (username == null) return;
    final data = await _userRepository.getUserProfile(username);
    if (data.isSuccess) {
      emit(state.copyWith(
        isSuccess: true,
        status: AppSettingStatus.success,
        action: AppSettingAction.updateProfile,
        profileAuthenticated: data.data,
        isLoading: false,
      ));
    }
  }

  void _updateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(state.copyWith(
      status: AppSettingStatus.loading,
      action: AppSettingAction.updateProfile,
    ));
    if (event.profile.id == -1 || event.profile.username.isEmpty) return;
    final res = await _userRepository.updateUser(event.profile);
    if (res.isSuccess) {
      emit(state.copyWith(
        status: AppSettingStatus.success,
        profileAuthenticated: res.data,
      ));
    } else {
      emit(state.copyWith(
        status: AppSettingStatus.error,
        errorMessage: res.errorMessage,
      ));
    }
  }

  void _updatePassword(
    UpdatePasswordEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(state.copyWith(
      status: AppSettingStatus.loading,
      action: AppSettingAction.changePassword,
    ));
    final res = await _userRepository.changePassword(event.passwordRaw);
    if (res.isSuccess) {
      emit(state.copyWith(status: AppSettingStatus.success));
    } else {
      emit(state.copyWith(
        status: AppSettingStatus.error,
        errorMessage: res.errorMessage,
      ));
    }
  }
}
