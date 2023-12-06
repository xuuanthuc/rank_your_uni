import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/university.dart';
import '../../../repositories/detail_repository.dart';

part 'compare_state.dart';

@injectable
class CompareCubit extends Cubit<CompareState> {
  final DetailRepository _detailRepository;

  CompareCubit(this._detailRepository) : super(const CompareState());

  void compareWith(int id) async {
    if (id == -1) return;
    emit(state.copyWith(status: CompareStatus.loading));
    final res = await _detailRepository.getDetailUniversity(id);
    if (res.isSuccess) {
      emit(state.copyWith(
        status: CompareStatus.success,
        compareWith: res.data,
      ));
    } else {
      emit(state.copyWith(status: CompareStatus.error));
    }
  }

  void initFirstUniversity(int id, University? university) async {
    if (id == -1) return;
    if (university != null) {
      emit(state.copyWith(
        status: CompareStatus.success,
        firstUniversity: university,
      ));
    } else {
      emit(state.copyWith(
        status: CompareStatus.loading,
      ));
      final res = await _detailRepository.getDetailUniversity(id);
      if (res.isSuccess) {
        emit(state.copyWith(
          status: CompareStatus.success,
          firstUniversity: res.data,
        ));
      } else {
        emit(state.copyWith(status: CompareStatus.error));
      }
    }
  }
}
