part of 'university_review_item_cubit.dart';

enum UniversityReviewItemStatus {
  loading,
  success,
  error,
}

enum UniversityReviewItemAction { like, dislike }

@immutable
class UniversityReviewItemState extends Equatable {
  final UniversityReviewItemStatus? status;
  final UniversityReviewItemAction? action;
  final UniversityReview? review;
  final Profile? userAuthenticated;

  const UniversityReviewItemState({
    this.status,
    this.review,
    this.action,
    this.userAuthenticated,
  });

  UniversityReviewItemState copyWith({
    UniversityReviewItemStatus? status,
    UniversityReview? review,
    UniversityReviewItemAction? action,
    Profile? userAuthenticated,
  }) {
    return UniversityReviewItemState(
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
