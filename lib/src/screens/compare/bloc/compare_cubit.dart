import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/university.dart';

part 'compare_state.dart';

@injectable
class CompareCubit extends Cubit<CompareState> {
  CompareCubit() : super(const CompareState());

  void compareWith(University university) {
    emit(state.copyWith(
      status: CompareStatus.loading,
      firstUniversity: state.firstUniversity,
    ));
    emit(
      state.copyWith(
          status: CompareStatus.success,
          compareWith: university,
          firstUniversity: state.firstUniversity),
    );
  }

  void initFirstUniversity(University university) {
    emit(state.copyWith(status: CompareStatus.loading));
    emit(
      state.copyWith(
        status: CompareStatus.success,
        firstUniversity: university,
      ),
    );
  }
}
