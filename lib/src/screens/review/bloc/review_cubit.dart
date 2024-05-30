import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/request/review_request.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/professor_review.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/screens/review/bloc/item_criteria_cubit.dart';
import 'package:template/src/screens/review/widgets/other_review_widgets.dart';
import '../../../../global/enum/criteria.dart';
import '../../../models/response/response.dart';
import '../../../models/response/tag.dart';
import '../../../models/response/university_review.dart';
import '../../../repositories/detail_repository.dart';

part 'review_state.dart';

@injectable
class ReviewCubit extends Cubit<ReviewState> {
  final DetailRepository _detailRepository;

  ReviewCubit(this._detailRepository) : super(const ReviewState());

  void getDetailUniversity(
      int id, University? university, UniversityReview? review) async {
    if (id == -1) return;
    if (review != null) {
      initUniversityReviewData(review);
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

  void initProfessorData(
      int id, Professor? professor, ProfessorReview? review) async {
    await getDetailProfessor(id, professor, review);
    getProfessorTags();
  }

  Future<void> getDetailProfessor(
      int id, Professor? professor, ProfessorReview? review) async {
    if (id == -1) return;
    if (review != null) {
      initProfessorReviewData(review);
    } else {
      emit(state.copyWith(mode: ReviewMode.create));
    }
    if (professor != null) {
      emit(state.copyWith(professor: professor));
    } else {
      final res = await _detailRepository.getDetailProfessor(id);
      if (res.isSuccess) {
        emit(state.copyWith(professor: res.data));
      } else {
        emit(state.copyWith(status: ReviewStatus.error));
      }
    }
  }

  void getProfessorTags() async {
    final res = await _detailRepository.getProfessorTags();
    if (res.isSuccess) {
      emit(state.copyWith(tags: res.data));
    } else {
      emit(state.copyWith(tags: []));
    }
  }

  void initUniversityReviewData(UniversityReview review) {
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
      mode: ReviewMode.edit,
    ));
  }

  void initProfessorReviewData(ProfessorReview review) {
    emit(state.copyWith(
      pedagogical: parsePoint((review.pedagogical ?? 0).toDouble()),
      professional: parsePoint((review.professional ?? 0).toDouble()),
      contentRated: review.contentRate,
      hard: parsePoint((review.hard ?? 0).toDouble()),
      hardAttendance: review.hardAttendance,
      courseName: review.courseName,
      point: review.point,
      reLearn: review.reLearn,
      selectedTags: review.tags,
      mode: ReviewMode.edit,
    ));
  }

  int parsePoint(double? point) {
    return int.tryParse(point.toString()) ?? 0;
  }

  void onDeleteUniversityReview(int id) async {
    emit(state.copyWith(
      status: ReviewStatus.loading,
      action: ReviewAction.delete,
    ));
    final res = await _detailRepository.deleteUniversityReview(id);
    if (res.isSuccess) {
      emit(state.copyWith(status: ReviewStatus.deleteSuccess));
    } else {
      emit(state.copyWith(status: ReviewStatus.error));
    }
  }

  void onDeleteProfessorReview(int id) async {
    emit(state.copyWith(
      status: ReviewStatus.loading,
      action: ReviewAction.delete,
    ));
    final res = await _detailRepository.deleteProfessorReview(id);
    if (res.isSuccess) {
      emit(state.copyWith(status: ReviewStatus.deleteSuccess));
    } else {
      emit(state.copyWith(status: ReviewStatus.error));
    }
  }

  void onSubmitUniversityReview(int schoolId, int userId,
      {UniversityReview? review}) async {
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
    ReviewUniversityRaw reviewRaw = ReviewUniversityRaw(
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

  void onSubmitProfessorReview(int teacherId, int userId,
      {ProfessorReview? review}) async {
    if (state.professional == null ||
        state.pedagogical == null ||
        state.status == ReviewStatus.loading ||
        state.hard == null ||
        state.courseName == null ||
        (state.contentRated ?? "").trim().isEmpty ||
        teacherId == -1) return;
    ReviewProfessorRaw reviewRaw = ReviewProfessorRaw(
      contentRated: state.contentRated!,
      pedagogical: state.pedagogical!,
      professional: state.professional!,
      hard: state.hard!,
      hardAttendance: state.hardAttendance,
      reLearn: state.reLearn,
      point: state.point,
      courseName: state.courseName!,
      tags: state.selectedTags ?? [],
      teacherId: teacherId,
      reviewDate: DateFormat("yyyy-MM-dd'T'hh:mm+07:00").format(DateTime.now()),
      userId: userId,
    );
    emit(state.copyWith(
      status: ReviewStatus.loading,
      action: ReviewAction.update,
    ));
    RYUResponse? res;
    if (state.mode == ReviewMode.create) {
      res = await _detailRepository.reviewProfessor(reviewRaw);
    } else if (state.mode == ReviewMode.edit && review != null) {
      res = await _detailRepository.updateProfessorReview(reviewRaw, review.id);
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

  void updateCourseName(String course) {
    emit(state.copyWith(courseName: course));
  }

  void updateHardAttendance(bool value) {
    emit(state.copyWith(hardAttendance: value));
  }

  void updateRelearn(bool value) {
    emit(state.copyWith(reLearn: value));
  }

  void updateSemesterPoint(String value) {
    emit(state.copyWith(point: value));
  }

  void updateTags(Tag tag) {
    emit(state.copyWith(modifiedAt: DateTime.now()));
    if ((state.selectedTags ?? []).any((t) => t.id == tag.id)) {
      emit(state.copyWith(
        selectedTags: (state.selectedTags ?? [])
          ..removeWhere((t) => t.id == tag.id),
        modifiedAt: DateTime.now(),
      ));
    } else {
      if ((state.selectedTags ?? []).length > 2) return;
      emit(state.copyWith(
        selectedTags: (state.selectedTags ?? [])..add(tag),
        modifiedAt: DateTime.now(),
      ));
    }
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
      case Criteria.pedagogical:
        emit(state.copyWith(pedagogical: rated.point.index + 1));
        break;
      case Criteria.professional:
        emit(state.copyWith(professional: rated.point.index + 1));
        break;
      case Criteria.hard:
        emit(state.copyWith(hard: rated.point.index + 1));
        break;
    }
  }
}
