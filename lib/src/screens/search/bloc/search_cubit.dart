import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../models/response/university.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  onSearch(String keyword) async {
    emit(state.copyWith(status: SearchStatus.init));
    final List<University> universities = [
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Đại học Bách khoa Hà Nội", address: "Hai Bà Trưng, Hà Nội"),
    ];

    emit(state.copyWith(
      status: SearchStatus.success,
      universities: universities,
    ));
  }

  loadMore() async {
    if (state.status == SearchStatus.loadingMore) return;
    emit(state.copyWith(status: SearchStatus.loadingMore));
    final List<University> universities = [
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
      const University(
          name: "Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội",
          address: "Hai Bà Trưng, Hà Nội"),
    ];
    state.universities?.addAll(universities);
    emit(state.copyWith(
        status: SearchStatus.success, universities: state.universities));
  }
}
