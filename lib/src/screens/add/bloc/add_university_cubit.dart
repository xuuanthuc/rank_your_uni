import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../global/utilities/extensions.dart';
import '../../../models/response/province.dart';

part 'add_university_state.dart';

@injectable
class AddUniversityCubit extends Cubit<AddUniversityState> {
  AddUniversityCubit() : super(const AddUniversityState());

  void getVNAddress() async {
    emit(state.copyWith(status: AddUniStatus.loading));
    List<Province> provinces = [];
    try {
      const releasePath = kDebugMode ? '' : 'assets/';
      final String response =
          await rootBundle.loadString('${releasePath}json/provinces.json');
      final data = await json.decode(response);
      data.forEach((e) {
        provinces.add(Province.fromJson(e));
      });
      emit(state.copyWith(
        provinces: provinces,
        searchingProvinces: provinces,
        status: AddUniStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        provinces: provinces,
        status: AddUniStatus.error,
      ));
    }
  }

  void filterProvince(String keyword) {
    if (keyword.trim().isEmpty) {
      emit(state.copyWith(searchingProvinces: state.provinces));
    } else {
      List<Province> provinces = [];
      for (final Province p in state.provinces ?? []) {
        if ((removeDiacritics(p.name?.toLowerCase() ?? ''))
            .contains(removeDiacritics(keyword.trim().toLowerCase()))) {
          provinces.add(p);
        }
      }
      emit(state.copyWith(searchingProvinces: provinces));
    }
  }

  void onSelectProvince(Province province){
    emit(state.copyWith(provinceSelected: province, searchingDistrics: province.districs));
  }

  void filterDistrics(String keyword) {
    if (keyword.trim().isEmpty) {
      emit(state.copyWith(searchingDistrics: state.provinceSelected?.districs));
    } else {
      List<Districts> districts = [];
      for (final Districts d in state.provinceSelected?.districs ?? []) {
        if ((removeDiacritics(d.name?.toLowerCase() ?? ''))
            .contains(removeDiacritics(keyword.trim().toLowerCase()))) {
          districts.add(d);
        }
      }
      emit(state.copyWith(searchingDistrics: districts));
    }
  }
}
