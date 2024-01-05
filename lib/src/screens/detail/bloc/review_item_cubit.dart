import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/profile.dart';
import '../../../models/response/response.dart';
import '../../../models/response/review.dart';
import '../../../repositories/detail_repository.dart';

part 'review_item_state.dart';

@injectable
class ReviewItemCubit extends Cubit<ReviewItemState> {
  final DetailRepository _detailRepository;

  ReviewItemCubit(this._detailRepository) : super(const ReviewItemState());

  void onInitReviewUI(Review review, Profile? currentUser) async {
    emit(state.copyWith(review: review, userAuthenticated: currentUser));
  }

  void upVoteReview(Review review, int userId) async {
    if(state.userAuthenticated == null) return;
    if(state.status == ReviewItemStatus.loading) return;
    if(state.userAuthenticated?.id == state.review?.userId) return;
    RYUResponse res;
    emit(state.copyWith(status: ReviewItemStatus.loading, action: ReviewItemAction.like));
    if((state.review?.liked?.userLiked ?? []).contains(userId)){
      res = await _detailRepository.undoReview(review.id, userId);
    } else {
      res = await _detailRepository.likeReview(review.id, userId);
    }
    if (res.isSuccess) {
      emit(state.copyWith(
        status: ReviewItemStatus.success,
        review: (res.data as Review)..averagePointPerReview = state.review?.averagePointPerReview,
      ));
    } else {
      emit(state.copyWith(status: ReviewItemStatus.error));
    }
  }

  void downVoteReview(Review review, int userId) async {
    if(state.userAuthenticated == null) return;
    if(state.status == ReviewItemStatus.loading) return;
    if(state.userAuthenticated?.id == state.review?.userId) return;
    RYUResponse res;
    emit(state.copyWith(status: ReviewItemStatus.loading, action: ReviewItemAction.dislike));
    if((state.review?.liked?.userDisLiked ?? []).contains(userId)){
      res = await _detailRepository.undoReview(review.id, userId);
    } else {
      res = await _detailRepository.dislikeReview(review.id, userId);
    }
    if (res.isSuccess) {
      emit(state.copyWith(
        status: ReviewItemStatus.success,
        review: (res.data as Review)..averagePointPerReview = state.review?.averagePointPerReview,
      ));
    } else {
      emit(state.copyWith(status: ReviewItemStatus.error));
    }
  }
}
