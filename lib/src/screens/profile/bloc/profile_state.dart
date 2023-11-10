part of 'profile_cubit.dart';

enum ProfileStatus { loading, success }

@immutable
class ProfileState extends Equatable {
  final QuickMenu? page;
  final ProfileStatus? status;

  const ProfileState({this.page, this.status});

  ProfileState copyWith({QuickMenu? page, ProfileStatus? status}) {
    return ProfileState(
      page: page ?? this.page,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        page,
        status,
      ];
}
