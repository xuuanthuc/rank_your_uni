import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:template/src/models/response/university.dart';

import '../../../repositories/search_repository.dart';

part 'detail_state.dart';

@injectable
class DetailCubit extends Cubit<DetailState> {
  final SearchRepository _searchRepository;

  DetailCubit(this._searchRepository) : super(const DetailState());

  void getDetailUniversity(int id) async {
    emit(state.copyWith(status: DetailStatus.loading));
    // try {
      final data = await _searchRepository.getDetailUniversity(id);
      emit(state.copyWith(status: DetailStatus.success, university: data));
    // } catch (e) {
    //   emit(state.copyWith(status: DetailStatus.error));
    // }
  }
}
