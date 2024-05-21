part of 'professor_review_item_cubit.dart';

enum ProfessorReviewItemStatus {
  loading,
  success,
  error,
}

enum ProfessorReviewItemAction { like, dislike }

@immutable
class ProfessorReviewItemState extends Equatable {
  final ProfessorReviewItemStatus? status;
  final ProfessorReviewItemAction? action;
  final ProfessorReview? review;
  final Profile? userAuthenticated;

  const ProfessorReviewItemState({
    this.status,
    this.review,
    this.action,
    this.userAuthenticated,
  });

  ProfessorReviewItemState copyWith({
    ProfessorReviewItemStatus? status,
    ProfessorReview? review,
    ProfessorReviewItemAction? action,
    Profile? userAuthenticated,
  }) {
    return ProfessorReviewItemState(
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
