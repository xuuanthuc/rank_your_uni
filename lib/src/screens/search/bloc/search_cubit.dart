import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/search_response.dart';
import 'package:template/src/repositories/search_repository.dart';

import '../../../models/response/university.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchState());

  onSearchUniversities(String keyword) async {
    final List<University> universities = [];
    emit(state.copyWith(status: SearchStatus.init));
    final res = await _searchRepository.getUniversities(keyword, 0);
    if (res.isSuccess) {
      universities.addAll(res.data.universities);
      final page = res.data.pageable.pageNumber;
      emit(state.copyWith(
        status: SearchStatus.success,
        currentPage: page,
        keyword: keyword,
        searchModel: res.data,
        universities: universities,
      ));
    } else {
      emit(state.copyWith(
        status: SearchStatus.error,
        universities: [],
      ));
    }
  }

  loadMoreUniversities() async {
    if (state.status == SearchStatus.loadingMore ||
        (state.keyword ?? '').isEmpty) return;
    final newPage = (state.currentPage ?? 0) + 1;
    if (state.searchModel == null ||
        newPage + 1 > state.searchModel!.totalPages) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loadingMore));
    final res = await _searchRepository.getUniversities(
      state.keyword!,
      newPage,
    );
    if (res.isSuccess) {
      (state.universities ?? []).addAll(res.data.universities);
      emit(state.copyWith(
        status: SearchStatus.success,
        currentPage: res.data.pageable.pageNumber,
      ));
    } else {
      emit(state.copyWith(
        status: SearchStatus.error,
        universities: [],
      ));
    }
  }

  onSearchProfessores(String keyword) async {
    final List<Professor> professores = [];
    emit(state.copyWith(status: SearchStatus.init));
    final res = await _searchRepository.getProfessores(keyword, 0);
    if (res.isSuccess) {
      professores.addAll((res.data as SearchProfessorModel).professores);
      final page = res.data.pageable.pageNumber;
      emit(state.copyWith(
        status: SearchStatus.success,
        currentPage: page,
        keyword: keyword,
        searchProfessorModel: res.data,
        professores: professores,
      ));
    } else {
      emit(state.copyWith(
        status: SearchStatus.error,
        professores: [],
      ));
    }
  }

  loadMoreProfessores() async {
    if (state.status == SearchStatus.loadingMore ||
        (state.keyword ?? '').isEmpty) return;
    final newPage = (state.currentPage ?? 0) + 1;
    if (state.searchProfessorModel == null ||
        newPage + 1 > state.searchProfessorModel!.totalPages) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loadingMore));
    final res = await _searchRepository.getProfessores(
      state.keyword!,
      newPage,
    );
    if (res.isSuccess) {
      (state.professores ?? []).addAll((res.data as SearchProfessorModel).professores);
      emit(state.copyWith(
        status: SearchStatus.success,
        currentPage: res.data.pageable.pageNumber,
      ));
    } else {
      emit(state.copyWith(
        status: SearchStatus.error,
        professores: [],
      ));
    }
  }
}
