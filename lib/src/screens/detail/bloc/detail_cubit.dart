import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/repositories/detail_repository.dart';

part 'detail_state.dart';

@injectable
class DetailCubit extends Cubit<DetailState> {
  final DetailRepository _detailRepository;

  DetailCubit(this._detailRepository) : super(const DetailState());

  void getDetailUniversity(int id, University? university) async {
    emit(state.copyWith(status: DetailStatus.loading, university: university));
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

  void changeSort(SortType sortType) {
    if (sortType == state.sortType) return;
    University? university = state.university;
    if (sortType == SortType.like) {
      university?.reviews?.sort(
          (first, second) => (second.like ?? 0).compareTo(first.like ?? 0));
    } else {
      university?.reviews?.sort(
        (first, second) => (DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
                .parse(second.reviewDate ?? '', true)
                .toUtc())
            .compareTo(DateFormat("yyyy-MM-dd'T'hh:mm:SSS'Z'")
                .parse(first.reviewDate ?? '', true)
                .toUtc()),
      );
    }
    emit(state.copyWith(university: university, sortType: sortType));
  }
}
