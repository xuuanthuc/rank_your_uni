part of 'review_item_cubit.dart';

enum ReviewItemStatus {
  loading,
  success,
  error,
}

enum ReviewItemAction { like, dislike }

@immutable
class ReviewItemState extends Equatable {
  final ReviewItemStatus? status;
  final ReviewItemAction? action;
  final UniversityReview? review;
  final Profile? userAuthenticated;

  const ReviewItemState({
    this.status,
    this.review,
    this.action,
    this.userAuthenticated,
  });

  ReviewItemState copyWith({
    ReviewItemStatus? status,
    UniversityReview? review,
    ReviewItemAction? action,
    Profile? userAuthenticated,
  }) {
    return ReviewItemState(
      status: status ?? this.status,
      review: review ?? this.review,
      action: action ?? this.action,
      userAuthenticated: userAuthenticated ?? this.userAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        status,
        review,
        action,
        userAuthenticated,
      ];
}
