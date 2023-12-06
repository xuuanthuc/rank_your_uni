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
  final Review? review;

  const ReviewItemState({this.status, this.review, this.action});

  ReviewItemState copyWith({
    ReviewItemStatus? status,
    Review? review,
    ReviewItemAction? action,
  }) {
    return ReviewItemState(
      status: status ?? this.status,
      review: review ?? this.review,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [
        status,
        review,
        action,
      ];
}
