part of 'review_item_cubit.dart';

enum ReviewItemStatus {
  loading,
  success,
  error,
}

@immutable
class ReviewItemState extends Equatable {
  final ReviewItemStatus? status;

  const ReviewItemState({this.status});

  ReviewItemState copyWith({ReviewItemStatus? status}) {
    return ReviewItemState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
