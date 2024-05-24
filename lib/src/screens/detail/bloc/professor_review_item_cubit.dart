import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/profile.dart';
import '../../../models/response/professor_review.dart';
import '../../../models/response/response.dart';
import '../../../repositories/detail_repository.dart';

part 'professor_review_item_state.dart';

@injectable
class ProfessorReviewItemCubit extends Cubit<ProfessorReviewItemState> {
  final DetailRepository _detailRepository;

  ProfessorReviewItemCubit(this._detailRepository)
      : super(const ProfessorReviewItemState());

  void onInitReviewUI(ProfessorReview review, Profile? currentUser) async {
    emit(state.copyWith(review: review, userAuthenticated: currentUser));
  }

  void upVoteReview(ProfessorReview review, int userId) async {
    if (state.userAuthenticated == null) return;
    if (state.status == ProfessorReviewItemStatus.loading) return;
    if (state.userAuthenticated?.id == state.review?.userId) return;
    RYUResponse res;
    emit(state.copyWith(
        status: ProfessorReviewItemStatus.loading,
        action: ProfessorReviewItemAction.like));
    if ((state.review?.liked?.userLiked ?? []).contains(userId)) {
      res = await _detailRepository.undoProfessorReview(review.id, userId);
    } else {
      res = await _detailRepository.likeProfessorReview(review.id, userId);
    }
    if (res.isSuccess) {
      emit(state.copyWith(
        status: ProfessorReviewItemStatus.success,
        review: (res.data as ProfessorReview)
          ..averagePointPerReview = state.review?.averagePointPerReview,
      ));
    } else {
      emit(state.copyWith(status: ProfessorReviewItemStatus.error));
    }
  }

  void downVoteReview(ProfessorReview review, int userId) async {
    if (state.userAuthenticated == null) return;
    if (state.status == ProfessorReviewItemStatus.loading) return;
    if (state.userAuthenticated?.id == state.review?.userId) return;
    RYUResponse res;
    emit(state.copyWith(
        status: ProfessorReviewItemStatus.loading,
        action: ProfessorReviewItemAction.dislike));
    if ((state.review?.liked?.userDisLiked ?? []).contains(userId)) {
      res = await _detailRepository.undoProfessorReview(review.id, userId);
    } else {
      res = await _detailRepository.dislikeProfessorReview(review.id, userId);
    }
    if (res.isSuccess) {
      emit(state.copyWith(
        status: ProfessorReviewItemStatus.success,
        review: (res.data as ProfessorReview)
          ..averagePointPerReview = state.review?.averagePointPerReview,
      ));
    } else {
      emit(state.copyWith(status: ProfessorReviewItemStatus.error));
    }
  }
}
