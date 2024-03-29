import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/repositories/search_repository.dart';

import '../../../models/response/major.dart';

part 'select_university_state.dart';

@injectable
class SelectUniversityCubit extends Cubit<SelectUniversityState> {
  SelectUniversityCubit(this._searchRepository)
      : super(const SelectUniversityState());

  final SearchRepository _searchRepository;

  selectUniversity(University? university) {
    emit(state.copyWith(university: university ?? const University(-1)));
  }

  selectMajors(Major major) {
    emit(state.copyWith(major: major));
  }

  getListMajors() async {
    final res = await _searchRepository.getMajors();
    if (res.isSuccess) {
      emit(state.copyWith(majors: res.data as List<Major>));
    } else {
      emit(state.copyWith(majors: []));
    }
  }
}
