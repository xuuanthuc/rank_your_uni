import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../models/response/review.dart';
import '../../../repositories/detail_repository.dart';

part 'review_item_state.dart';

@injectable
class ReviewItemCubit extends Cubit<ReviewItemState> {
  final DetailRepository _detailRepository;

  ReviewItemCubit(this._detailRepository) : super(const ReviewItemState());

  void upVoteReview(Review review) async {
    emit(state.copyWith(status: ReviewItemStatus.loading));
    try {
      final isSuccess = await _detailRepository.likeReview(review.id);
      if (isSuccess) {
        emit(state.copyWith(status: ReviewItemStatus.success));
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(state.copyWith(status: ReviewItemStatus.error));
    }
  }

  void downVoteReview(Review review) async {
    emit(state.copyWith(status: ReviewItemStatus.loading));
    try {
      final isSuccess = await _detailRepository.dislikeReview(review.id);
      if (isSuccess) {
        emit(state.copyWith(status: ReviewItemStatus.success));
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(state.copyWith(status: ReviewItemStatus.error));
    }
  }
}
