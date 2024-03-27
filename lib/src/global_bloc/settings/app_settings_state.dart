part of 'app_settings_bloc.dart';

enum AppSettingStatus { loading, success, error }

enum AppSettingAction { updateProfile, changePassword, changeSearchType }

enum SearchType { university, professor }

@injectable
class AppSettingsState extends Equatable {
  final String? errorMessage;
  final AppSettingStatus? status;
  final AppSettingAction? action;
  final Profile? profileAuthenticated;
  final SearchType? type;

  const AppSettingsState({
    this.status,
    this.action,
    this.errorMessage,
    this.profileAuthenticated,
    this.type,
  });

  AppSettingsState copyWith(
      {bool? isLoading,
      AppSettingStatus? status,
      AppSettingAction? action,
      bool? isSuccess,
      bool? isError,
      String? errorMessage,
      Profile? profileAuthenticated,
      SearchType? type}) {
    return AppSettingsState(
      status: status ?? this.status,
      action: action ?? this.action,
      errorMessage: errorMessage,
      profileAuthenticated: profileAuthenticated ?? this.profileAuthenticated,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        status,
        action,
        errorMessage,
        profileAuthenticated,
        type,
      ];
}
