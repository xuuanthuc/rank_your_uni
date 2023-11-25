import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../global/utilities/extensions.dart';
import '../../../models/request/add_university_request.dart';
import '../../../models/response/province.dart';

part 'select_province_state.dart';

@injectable
class SelectProvinceCubit extends Cubit<SelectProvinceState> {
  SelectProvinceCubit() : super(const SelectProvinceState());

  void getVNAddress() async {
    emit(state.copyWith(
        status: SelectStatus.loading, action: SelectedAction.init));
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
        status: SelectStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        provinces: provinces,
        status: SelectStatus.error,
      ));
    }
  }

  void filterProvince(String keyword) {
    if (keyword.trim().isEmpty) {
      emit(state.copyWith(
        searchingProvinces: state.provinces,
        action: SelectedAction.init,
      ));
    } else {
      List<Province> provinces = [];
      for (final Province p in state.provinces ?? []) {
        if ((removeDiacritics(p.name?.toLowerCase() ?? ''))
            .contains(removeDiacritics(keyword.trim().toLowerCase()))) {
          provinces.add(p);
        }
      }
      emit(state.copyWith(
        searchingProvinces: provinces,
        action: SelectedAction.init,
      ));
    }
  }

  void onSelectProvince(Province province) {
    emit(state.copyWith(
      provinceSelected: province,
      searchingDistrics: province.districs,
      action: SelectedAction.selectDistrict,
    ));
  }

  void onDeselectProvince() {
    emit(state.copyWith(
      searchingProvinces: state.provinces,
      action: SelectedAction.init,
    ));
  }

  void filterDistrics(String keyword) {
    if (keyword.trim().isEmpty) {
      emit(state.copyWith(
        searchingDistrics: state.provinceSelected?.districs,
        action: SelectedAction.selectDistrict,
        provinceSelected: state.provinceSelected,
      ));
    } else {
      List<Districts> districts = [];
      for (final Districts d in state.provinceSelected?.districs ?? []) {
        if ((removeDiacritics(d.name?.toLowerCase() ?? ''))
            .contains(removeDiacritics(keyword.trim().toLowerCase()))) {
          districts.add(d);
        }
      }
      emit(state.copyWith(
        searchingDistrics: districts,
        action: SelectedAction.selectDistrict,
        provinceSelected: state.provinceSelected,
      ));
    }
  }

  void onSelectedProvinceDistrict(){
    emit(state.copyWith());
  }
}
