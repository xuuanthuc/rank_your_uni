part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();
}

class UpdateUserProfileEvent extends AppSettingsEvent {
  final ProfileRaw profile;

  const UpdateUserProfileEvent(this.profile);

  @override
  List<Object?> get props => [];
}

class UpdatePasswordEvent extends AppSettingsEvent {
  final PasswordRaw passwordRaw;

  const UpdatePasswordEvent(this.passwordRaw);

  @override
  List<Object?> get props => [];
}

class GetUserProfileEvent extends AppSettingsEvent {
  @override
  List<Object?> get props => [];
}

class InitUserProfileEvent extends AppSettingsEvent {
  final Profile profile;

  const InitUserProfileEvent(
    this.profile,
  );

  @override
  List<Object?> get props => [
        profile,
      ];
}

class ChangeSearchTypeEvent extends AppSettingsEvent {
  @override
  List<Object?> get props => [];
}
