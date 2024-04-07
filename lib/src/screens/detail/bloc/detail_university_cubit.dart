import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/response/profile.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/repositories/detail_repository.dart';
import '../../../../global/storage/storage_keys.dart';
import '../../../../global/storage/storage_provider.dart';
import '../../../models/response/review.dart';

part 'detail_university_state.dart';

@injectable
class DetailUniversityCubit extends Cubit<DetailUniversityState> {
  final DetailRepository _detailRepository;

  DetailUniversityCubit(this._detailRepository) : super(const DetailUniversityState());

  void getDetailUniversity(int id, University? university) async {
    Profile? user;
    final userJson = await StorageProvider.instance.get(StorageKeys.user);
    if (userJson != null) {
      user = Profile.fromJson(jsonDecode(userJson));
    }
    emit(state.copyWith(
      status: DetailStatus.loading,
      university: university?..reviews?.clear(),
      userAuthenticated: user,
    ));
    final res = await _detailRepository.getDetailUniversity(id);
    if (res.isSuccess) {
      emit(state.copyWith(
        status: DetailStatus.success,
        university: res.data,
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
    University? university = state.university;
    emit(state.copyWith(
      status: DetailStatus.loading,
      sortType: sortType,
    ));
    if (sortType == SortType.like) {
      await compute(sortReviewByUseful, university?.reviews ?? []);
    } else {
      await compute(sortReviewByDate, university?.reviews ?? []);
    }
    emit(state.copyWith(
      university: university,
      status: DetailStatus.success,
    ));
  }

  List<Review> sortReviewByDate(List<Review> reviews) {
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

  List<Review> sortReviewByUseful(List<Review> reviews) {
    reviews.sort(
      (first, second) => (second.liked?.userLiked?.length ?? 0)
          .compareTo(first.liked?.userLiked?.length ?? 0),
    );
    return reviews;
  }
}
