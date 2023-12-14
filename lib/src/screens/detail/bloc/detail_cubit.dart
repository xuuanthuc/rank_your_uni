import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/repositories/detail_repository.dart';
import '../../../models/response/review.dart';

part 'detail_state.dart';

@injectable
class DetailCubit extends Cubit<DetailState> {
  final DetailRepository _detailRepository;

  DetailCubit(this._detailRepository) : super(const DetailState());

  void getDetailUniversity(int id, University? university) async {
    emit(state.copyWith(
        status: DetailStatus.loading,
        university: university?..reviews?.clear()));
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

  void changeSort(SortType sortType) async {
    if (sortType == state.sortType) return;
    List<Review> newReviews = [];
    University? university = state.university;
    University? newUni = state.university?.copyWith(newReviews: newReviews);

    emit(state.copyWith(
      university: newUni,
      status: DetailStatus.loading,
      sortType: sortType,
    ));
    await Future.delayed(const Duration(milliseconds: 100), () async {
      if (sortType == SortType.like) {
        await compute(sortReviewByUseful, university?.reviews ?? []);
      } else {
        await compute(sortReviewByDate, university?.reviews ?? []);
      }
    });
    emit(state.copyWith(
      university: university,
      status: DetailStatus.success,
    ));
  }

  List<Review> sortReviewByDate(List<Review> reviews) {
    print(2);
    reviews.sort(
      (first, second) => (DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
              .parse(second.reviewDate ?? '', true)
              .toUtc())
          .compareTo(DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
              .parse(first.reviewDate ?? '', true)
              .toUtc()),
    );
    print(3);
    return reviews;
  }

  List<Review> sortReviewByUseful(List<Review> reviews) {
    print(2);
    reviews
        .sort((first, second) => (second.like ?? 0).compareTo(first.like ?? 0));
    print(3);
    return reviews;
  }
}
