import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/university.dart';
import 'package:template/src/models/response/updated_university.dart';

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
        final UniversityUpdated resUni = res.data as UniversityUpdated;
        final newUni = University(
          state.university!.id,
          name: state.university!.name,
          abbrevia: state.university!.abbrevia,
          website: state.university!.website,
          address: state.university!.address,
          averagePointAllReviews: state.university!.averagePointAllReviews,
          phone: state.university!.phone,
          reviews: state.university!.reviews,
          reputationAvg: state.university!.reputationAvg,
          internetAvg: state.university!.internetAvg,
          locationAvg: state.university!.locationAvg,
          facilitiesAvg: state.university!.facilitiesAvg,
          foodAvg: state.university!.foodAvg,
          clubsAvg: state.university!.clubsAvg,
          favoriteAvg: state.university!.favoriteAvg,
          competitionLevelAvg: state.university!.competitionLevelAvg,
          totalReviews: state.university!.totalReviews,
          status: resUni.status,
        );
        emit(state.copyWith(
          university: newUni,
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
      final res = await _adminRepository.updateUniversity(
        newUniversity,
        state.university!,
      );
      if (res.isSuccess) {
        final UniversityUpdated resUni = res.data as UniversityUpdated;
        final newUni = University(
          state.university!.id,
          name: resUni.name,
          abbrevia: resUni.abbrevia,
          website: resUni.website,
          address: resUni.address,
          averagePointAllReviews: state.university!.averagePointAllReviews,
          phone: resUni.phone,
          reviews: state.university!.reviews,
          reputationAvg: state.university!.reputationAvg,
          internetAvg: state.university!.internetAvg,
          locationAvg: state.university!.locationAvg,
          facilitiesAvg: state.university!.facilitiesAvg,
          foodAvg: state.university!.foodAvg,
          clubsAvg: state.university!.clubsAvg,
          favoriteAvg: state.university!.favoriteAvg,
          competitionLevelAvg: state.university!.competitionLevelAvg,
          totalReviews: state.university!.totalReviews,
          status: resUni.status,
        );
        emit(state.copyWith(
          university: newUni,
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

  void deleteUniversity() async {
    if (state.university != null) {
      emit(state.copyWith(
        status: DashboardUniversityStatus.loading,
      ));

      final res = await _adminRepository.deleteUniversity(state.university!);
      if (res.isSuccess) {
        emit(const DashboardUniversityItemState(
          status: DashboardUniversityStatus.success,
          university: null,
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
