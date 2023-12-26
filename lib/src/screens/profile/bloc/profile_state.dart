part of 'profile_cubit.dart';

enum ProfileStatus { loading, success }

@immutable
class ProfileState extends Equatable {
  final QuickMenu? page;
  final ProfileStatus? status;
  final bool? isEditting;

  const ProfileState({this.page, this.status, this.isEditting});

  ProfileState copyWith(
      {QuickMenu? page, ProfileStatus? status, bool? isEditting}) {
    return ProfileState(
      page: page ?? this.page,
      status: status ?? this.status,
      isEditting: isEditting ?? this.isEditting,
    );
  }

  @override
  List<Object?> get props => [
        page,
        status,
        isEditting,
      ];
}
