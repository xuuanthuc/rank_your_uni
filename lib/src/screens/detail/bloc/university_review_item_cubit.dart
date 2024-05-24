import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/profile.dart';
import '../../../models/response/response.dart';
import '../../../models/response/university_review.dart';
import '../../../repositories/detail_repository.dart';

part 'university_review_item_state.dart';

@injectable
class UniversityReviewItemCubit extends Cubit<UniversityReviewItemState> {
  final DetailRepository _detailRepository;

  UniversityReviewItemCubit(this._detailRepository) : super(const UniversityReviewItemState());

  void onInitReviewUI(UniversityReview review, Profile? currentUser) async {
    emit(state.copyWith(review: review, userAuthenticated: currentUser));
  }

  void upVoteReview(UniversityReview review, int userId) async {
    if(state.userAuthenticated == null) return;
    if(state.status == UniversityReviewItemStatus.loading) return;
    if(state.userAuthenticated?.id == state.review?.userId) return;
    RYUResponse res;
    emit(state.copyWith(status: UniversityReviewItemStatus.loading, action: UniversityReviewItemAction.like));
    if((state.review?.liked?.userLiked ?? []).contains(userId)){
      res = await _detailRepository.undoUniversityReview(review.id, userId);
    } else {
      res = await _detailRepository.likeUniversityReview(review.id, userId);
    }
    if (res.isSuccess) {
      emit(state.copyWith(
        status: UniversityReviewItemStatus.success,
        review: (res.data as UniversityReview)..averagePointPerReview = state.review?.averagePointPerReview,
      ));
    } else {
      emit(state.copyWith(status: UniversityReviewItemStatus.error));
    }
  }

  void downVoteReview(UniversityReview review, int userId) async {
    if(state.userAuthenticated == null) return;
    if(state.status == UniversityReviewItemStatus.loading) return;
    if(state.userAuthenticated?.id == state.review?.userId) return;
    RYUResponse res;
    emit(state.copyWith(status: UniversityReviewItemStatus.loading, action: UniversityReviewItemAction.dislike));
    if((state.review?.liked?.userDisLiked ?? []).contains(userId)){
      res = await _detailRepository.undoUniversityReview(review.id, userId);
    } else {
      res = await _detailRepository.dislikeUniversityReview(review.id, userId);
    }
    if (res.isSuccess) {
      emit(state.copyWith(
        status: UniversityReviewItemStatus.success,
        review: (res.data as UniversityReview)..averagePointPerReview = state.review?.averagePointPerReview,
      ));
    } else {
      emit(state.copyWith(status: UniversityReviewItemStatus.error));
    }
  }
}
