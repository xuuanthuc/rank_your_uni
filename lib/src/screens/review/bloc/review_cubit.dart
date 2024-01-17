import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/request/review_request.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/review/bloc/item_criteria_cubit.dart';
import '../../../../global/enum/criteria.dart';
import '../../../models/response/response.dart';
import '../../../models/response/review.dart';
import '../../../repositories/detail_repository.dart';

part 'review_state.dart';

@injectable
class ReviewCubit extends Cubit<ReviewState> {
  final DetailRepository _detailRepository;

  ReviewCubit(this._detailRepository) : super(const ReviewState());

  void getDetailUniversity(
      int id, University? university, Review? review) async {
    if (id == -1) return;
    if (review != null) {
      initEditReviewMode(review);
    } else {
      emit(state.copyWith(mode: ReviewMode.create));
    }
    if (university != null) {
      emit(state.copyWith(university: university));
    } else {
      final res = await _detailRepository.getDetailUniversity(id);
      if (res.isSuccess) {
        emit(state.copyWith(university: res.data));
      } else {
        emit(state.copyWith(status: ReviewStatus.error));
      }
    }
  }

  void initEditReviewMode(Review review) {
    emit(state.copyWith(
        reputation: parsePoint(review.reputation),
        contentRated: review.content,
        competition: parsePoint(review.competition),
        location: parsePoint(review.location),
        internet: parsePoint(review.internet),
        favorite: parsePoint(review.favourite),
        facilities: parsePoint(review.facilities),
        clubs: parsePoint(review.clubs),
        food: parsePoint(review.food),
        mode: ReviewMode.edit));
  }

  int parsePoint(double? point) {
    return int.tryParse(point.toString()) ?? 0;
  }

  void onDeleteReview(int id) async {
    emit(state.copyWith(
      status: ReviewStatus.loading,
      action: ReviewAction.delete,
    ));
    final res = await _detailRepository.deleteReview(id);
    if (res.isSuccess) {
      emit(state.copyWith(status: ReviewStatus.deleteSuccess));
    } else {
      emit(state.copyWith(status: ReviewStatus.error));
    }
  }

  void onSubmitReview(int schoolId, int userId, {Review? review}) async {
    if (state.internet == null ||
        state.location == null ||
        state.status == ReviewStatus.loading ||
        state.reputation == null ||
        state.favorite == null ||
        state.food == null ||
        state.facilities == null ||
        state.competition == null ||
        (state.contentRated ?? "").trim().isEmpty ||
        state.clubs == null ||
        schoolId == -1) return;
    ReviewRaw reviewRaw = ReviewRaw(
      contentRated: state.contentRated!,
      reputation: state.reputation!,
      internet: state.internet!,
      location: state.location!,
      facilities: state.facilities!,
      food: state.food!,
      clubs: state.clubs!,
      favorite: state.favorite!,
      competitionLevel: state.competition!,
      schoolId: schoolId,
      reviewDate: DateFormat("yyyy-MM-dd'T'hh:mm+07:00").format(DateTime.now()),
      userId: userId,
    );
    emit(state.copyWith(
      status: ReviewStatus.loading,
      action: ReviewAction.update,
    ));
    RYUResponse? res;
    if (state.mode == ReviewMode.create) {
      res = await _detailRepository.reviewUniversity(reviewRaw);
    } else if (state.mode == ReviewMode.edit && review != null) {
      res = await _detailRepository.updateReview(reviewRaw, review.id);
    }
    if (res != null && res.isSuccess) {
      emit(state.copyWith(status: ReviewStatus.success));
    } else {
      emit(state.copyWith(status: ReviewStatus.error));
    }
  }

  void updateContent(String content) {
    emit(state.copyWith(contentRated: content));
  }

  void onUpdateReview(CriteriaRated rated) {
    switch (rated.criteria) {
      case Criteria.reputation:
        emit(state.copyWith(reputation: rated.point.index + 1));
        break;
      case Criteria.competition:
        emit(state.copyWith(competition: rated.point.index + 1));
        break;
      case Criteria.location:
        emit(state.copyWith(location: rated.point.index + 1));
        break;
      case Criteria.internet:
        emit(state.copyWith(internet: rated.point.index + 1));
        break;
      case Criteria.favorite:
        emit(state.copyWith(favorite: rated.point.index + 1));
        break;
      case Criteria.infrastructure:
        emit(state.copyWith(facilities: rated.point.index + 1));
        break;
      case Criteria.clubs:
        emit(state.copyWith(clubs: rated.point.index + 1));
        break;
      case Criteria.food:
        emit(state.copyWith(food: rated.point.index + 1));
        break;
    }
  }
}
