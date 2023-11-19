import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/global/utilities/logger.dart';
import 'package:template/src/models/response/search_response.dart';
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
      final data = await _searchRepository.getUniversities(keyword, 0);
      universities.addAll(data.universities);
      final page = data.pageable.pageNumber;
      emit(state.copyWith(
        status: SearchStatus.success,
        currentPage: page,
        keyword: keyword,
        searchModel: data,
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
    if (state.status == SearchStatus.loadingMore ||
        (state.keyword ?? '').isEmpty) return;
    final newPage = (state.currentPage ?? 0) + 1;
    if (state.searchModel == null ||
        newPage + 1 > state.searchModel!.totalPages) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loadingMore));
    try {
      final data =
          await _searchRepository.getUniversities(state.keyword!, newPage);
      (state.universities ?? []).addAll(data.universities);
      emit(state.copyWith(
        status: SearchStatus.success,
        currentPage: data.pageable.pageNumber,
      ));
    } catch (e) {
      LoggerUtils.e(e);
      emit(state.copyWith(
        status: SearchStatus.error,
        universities: [],
      ));
    }
  }
}
