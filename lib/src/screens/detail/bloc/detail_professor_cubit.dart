import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/profile.dart';
import 'package:template/src/repositories/detail_repository.dart';
import '../../../../global/enum/review_sort_type.dart';
import '../../../../global/storage/storage_keys.dart';
import '../../../../global/storage/storage_provider.dart';
import '../../../models/response/professor_review.dart';
import 'detail_university_cubit.dart';

part 'detail_professor_state.dart';

@injectable
class DetailProfessorCubit extends Cubit<DetailProfessorState> {
  final DetailRepository _detailRepository;

  DetailProfessorCubit(this._detailRepository) : super(const DetailProfessorState());

  void getDetailProfessor(int id, Professor? professor) async {
    Profile? user;
    final userJson = await StorageProvider.instance.get(StorageKeys.user);
    if (userJson != null) {
      user = Profile.fromJson(jsonDecode(userJson));
    }
    emit(state.copyWith(
      status: DetailStatus.loading,
      professor: professor?..reviews?.clear(),
      userAuthenticated: user,
    ));
    final res = await _detailRepository.getDetailProfessor(id);
    if (res.isSuccess) {
      emit(state.copyWith(
        status: DetailStatus.success,
        professor: res.data,
        sortType: SortType.date,
      ));
    } else {
      emit(state.copyWith(status: DetailStatus.error));
    }
  }

  void updateCurrentUser(Profile? currentUser) async {
    if (currentUser == null) return;
    emit(state.copyWith(userAuthenticated: currentUser));
  }

  void changeSort(SortType sortType) async {
    if (sortType == state.sortType) return;
    Professor? professor = state.professor;
    emit(state.copyWith(
      status: DetailStatus.loading,
      sortType: sortType,
    ));
    if (sortType == SortType.like) {
      await compute(sortReviewByUseful, professor?.reviews ?? []);
    } else {
      await compute(sortReviewByDate, professor?.reviews ?? []);
    }
    emit(state.copyWith(
      professor: professor,
      status: DetailStatus.success,
    ));
  }

  List<ProfessorReview> sortReviewByDate(List<ProfessorReview> reviews) {
    reviews.sort(
      (first, second) => (DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
              .parse(second.reviewDate ?? '', true)
              .toUtc())
          .compareTo(DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
              .parse(first.reviewDate ?? '', true)
              .toUtc()),
    );
    return reviews;
  }

  List<ProfessorReview> sortReviewByUseful(List<ProfessorReview> reviews) {
    reviews.sort(
      (first, second) => (second.liked?.userLiked?.length ?? 0)
          .compareTo(first.liked?.userLiked?.length ?? 0),
    );
    return reviews;
  }
}
