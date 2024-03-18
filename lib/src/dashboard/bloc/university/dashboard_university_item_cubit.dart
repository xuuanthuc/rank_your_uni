import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/university.dart';

import '../../../models/request/update_university_request.dart';
import '../../../repositories/dashboard_repository.dart';

part 'dashboard_university_item_state.dart';

@injectable
class DashboardUniversityItemCubit extends Cubit<DashboardUniversityItemState> {
  final DashboardRepository _adminRepository;

  DashboardUniversityItemCubit(this._adminRepository)
      : super(const DashboardUniversityItemState());

  void getUniversity(University university) {
    emit(state.copyWith(university: university));
  }

  void approveUniversity() async {
    if (state.university != null) {
      emit(state.copyWith(
        status: DashboardUniversityStatus.loading,
      ));
      final UpdateUniversityRaw newUniversity = UpdateUniversityRaw(
        name: state.university!.name,
        code: state.university!.abbrevia,
        address: state.university!.address,
        website: state.university!.website,
        status: 1,
      );
      final res = await _adminRepository.updateUniversity(
        newUniversity,
        state.university!,
      );
      if (res.isSuccess) {
        emit(state.copyWith(
          university: res.data as University,
          status: DashboardUniversityStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: DashboardUniversityStatus.error,
          errorMessage: res.errorMessage,
        ));
      }
    }
  }

  void updateUniversity(UpdateUniversityRaw newUniversity) async {
    if (state.university != null) {
      emit(state.copyWith(
        status: DashboardUniversityStatus.loading,
      ));
      final University university = University(
        state.university?.id ?? -1,
        address: newUniversity.address,
        name: newUniversity.name,
      );

      emit(state.copyWith(
        university: university,
        status: DashboardUniversityStatus.success,
      ));
    }
  }

  void deleteUniversity() async {
    if (state.university != null) {
      emit(state.copyWith(
        status: DashboardUniversityStatus.loading,
      ));

      final res = await _adminRepository.deleteUniversity(state.university!);
      if (res.isSuccess) {
        emit(state.copyWith(
          status: DashboardUniversityStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: DashboardUniversityStatus.error,
          errorMessage: res.errorMessage,
        ));
      }
    }
  }
}
