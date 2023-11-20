part of 'review_cubit.dart';

enum ReviewStatus { success, error, loading }

@immutable
class ReviewState extends Equatable {
  final ReviewStatus? status;
  final University? university;
  final String? contentRated;
  final int? reputation;
  final int? internet;
  final int? location;
  final int? facilities;
  final int? food;
  final int? clubs;
  final int? favorite;
  final int? competition;

  const ReviewState({
    this.contentRated,
    this.reputation,
    this.internet,
    this.location,
    this.facilities,
    this.food,
    this.clubs,
    this.favorite,
    this.competition,
    this.status,
    this.university,
  });

  ReviewState copyWith({
    ReviewStatus? status,
    University? university,
    String? contentRated,
    int? reputation,
    int? internet,
    int? location,
    int? facilities,
    int? food,
    int? clubs,
    int? favorite,
    int? competition,
    int? schoolId,
  }) {
    return ReviewState(
      status: status ?? this.status,
      university: university ?? this.university,
      reputation: reputation ?? this.reputation,
      clubs: clubs ?? this.clubs,
      competition: competition ?? this.competition,
      contentRated: contentRated ?? this.contentRated,
      internet: internet ?? this.internet,
      location: location ?? this.location,
      facilities: facilities ?? this.facilities,
      food: food ?? this.food,
      favorite: favorite ?? this.favorite,
    );
  }

  @override
  List<Object?> get props => [
        university,
        contentRated,
        reputation,
        internet,
        location,
        facilities,
        food,
        clubs,
        favorite,
        competition,
        status,
      ];
}
