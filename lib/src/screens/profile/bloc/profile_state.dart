part of 'profile_cubit.dart';

enum ProfileStatus { loading, success, error }

@immutable
class ProfileState extends Equatable {
  final QuickMenu? page;
  final Profile? userAuthenticated;
  final ProfileStatus? status;
  final List<Review>? reviews;
  final bool? canEdit;

  const ProfileState({
    this.page,
    this.status,
    this.reviews,
    this.userAuthenticated,
    this.canEdit,
  });

  ProfileState copyWith({
    QuickMenu? page,
    ProfileStatus? status,
    List<Review>? reviews,
    Profile? userAuthenticated,
    bool? canEdit,
  }) {
    return ProfileState(
      page: page ?? this.page,
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      canEdit: canEdit ?? this.canEdit,
      userAuthenticated: userAuthenticated ?? this.userAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        page,
        status,
        reviews,
        userAuthenticated,
        canEdit,
      ];
}
