part of 'profile_cubit.dart';

enum ProfileStatus { loading, success, error }

@immutable
class ProfileState extends Equatable {
  final QuickMenu? page;
  final ProfileStatus? status;
  final List<Review>? reviews;

  const ProfileState({
    this.page,
    this.status,
    this.reviews,
  });

  ProfileState copyWith({
    QuickMenu? page,
    ProfileStatus? status,
    List<Review>? reviews,
  }) {
    return ProfileState(
      page: page ?? this.page,
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  List<Object?> get props => [
        page,
        status,
        reviews,
      ];
}
