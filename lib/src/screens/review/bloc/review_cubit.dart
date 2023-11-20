import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/request/review_request.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/review/bloc/item_criteria_cubit.dart';
import '../../../../global/enum/criteria.dart';
import '../../../repositories/detail_repository.dart';

part 'review_state.dart';

@injectable
class ReviewCubit extends Cubit<ReviewState> {
  final DetailRepository _detailRepository;

  ReviewCubit(this._detailRepository) : super(const ReviewState());

  void getDetailUniversity(int id) async {
    if (id == 0) return;
    try {
      final data = await _detailRepository.getDetailUniversity(id);
      emit(state.copyWith(university: data));
    } catch (e) {
      emit(state.copyWith(status: ReviewStatus.error));
    }
  }

  void onSubmitReview(int schoolId) async {
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
        schoolId == 0) return;
    emit(state.copyWith(status: ReviewStatus.loading));
    try {
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
        reviewDate:
            DateFormat("yyyy-MM-dd'T'hh:mm+07:00").format(DateTime.now()),
      );
      final isSuccess = await _detailRepository.reviewUniversity(reviewRaw);
      if (isSuccess) {
        emit(state.copyWith(status: ReviewStatus.success));
      }
    } catch (e) {
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
