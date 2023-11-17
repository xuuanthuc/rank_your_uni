import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/repositories/search_repository.dart';

import '../../../models/response/university.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchState());

  onSearch(String keyword) async {
    final List<University> universities = [];
    if (keyword.length < 3) {
      return emit(state.copyWith(
        status: SearchStatus.success,
        universities: universities,
      ));
    }
    emit(state.copyWith(status: SearchStatus.init));
    try {
      final data = await _searchRepository.getUniversities(keyword);
      universities.addAll(data);
      emit(state.copyWith(
        status: SearchStatus.success,
        universities: universities,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.error,
        universities: [],
      ));
    }
  }

  loadMore() async {
    if (state.status == SearchStatus.loadingMore) return;
    emit(state.copyWith(status: SearchStatus.loadingMore));
    final List<University> universities = [];
    state.universities?.addAll(universities);
    emit(state.copyWith(
      status: SearchStatus.success,
      universities: state.universities,
    ));
  }
}
