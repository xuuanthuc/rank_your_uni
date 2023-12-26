part of 'app_settings_bloc.dart';

enum AppSettingStatus { loading, success, error }

enum AppSettingAction { updateProfile, changePassword }

@injectable
class AppSettingsState extends Equatable {
  final String? errorMessage;
  final AppSettingStatus? status;
  final AppSettingAction? action;
  final Profile? profileAuthenticated;

  const AppSettingsState({
    this.status,
    this.action,
    this.errorMessage,
    this.profileAuthenticated,
  });

  AppSettingsState copyWith({
    bool? isLoading,
    AppSettingStatus? status,
    AppSettingAction? action,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    Profile? profileAuthenticated,
  }) {
    return AppSettingsState(
      status: status ?? this.status,
      action: action ?? this.action,
      errorMessage: errorMessage,
      profileAuthenticated: profileAuthenticated ?? this.profileAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        status,
        action,
        errorMessage,
        profileAuthenticated,
      ];
}
