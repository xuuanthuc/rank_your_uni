import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/update_professor_request.dart';
import 'package:template/src/models/response/professor.dart';
import '../../../models/request/update_university_request.dart';
import '../../../repositories/dashboard_repository.dart';

part 'dashboard_professor_item_state.dart';

@injectable
class DashboardProfessorItemCubit extends Cubit<DashboardProfessorItemState> {
  final DashboardRepository _adminRepository;

  DashboardProfessorItemCubit(this._adminRepository)
      : super(const DashboardProfessorItemState());

  void getProfessors(Professor professor) {
    emit(state.copyWith(professor: professor));
  }

  void approveProfessor() async {
    final professor = state.professor;
    if (professor != null) {
      emit(state.copyWith(
        status: DashboardProfessorStatus.loading,
      ));
      final UpdateProfessorRaw newProfessor = UpdateProfessorRaw(
        professor.id,
        fullName: professor.fullName,
        universityId: professor.university?.id,
        majorId: professor.major?.id,
        status: true,
      );
      final res = await _adminRepository.updateProfessor(newProfessor);
      if (res.isSuccess) {
        final Professor resProfessor = res.data as Professor;
        final newProfessor = Professor(
          professor.id,
          fullName: professor.fullName,
          university: professor.university,
          major: professor.major,
          status: resProfessor.status,
        );
        emit(state.copyWith(
          professor: newProfessor,
          status: DashboardProfessorStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: DashboardProfessorStatus.error,
          errorMessage: res.errorMessage,
        ));
      }
    }
  }

  void updateProfessor(UpdateUniversityRaw newUniversity) async {
    // if (state.university != null) {
    //   emit(state.copyWith(
    //     status: DashboardUniversityStatus.loading,
    //   ));
    //   final res = await _adminRepository.updateUniversity(
    //     newUniversity,
    //     state.university!,
    //   );
    //   if (res.isSuccess) {
    //     final UniversityUpdated resUni = res.data as UniversityUpdated;
    //     final newUni = University(
    //       state.university!.id,
    //       name: resUni.name,
    //       abbrevia: resUni.abbrevia,
    //       website: resUni.website,
    //       address: resUni.address,
    //       averagePointAllReviews: state.university!.averagePointAllReviews,
    //       phone: resUni.phone,
    //       reviews: state.university!.reviews,
    //       reputationAvg: state.university!.reputationAvg,
    //       internetAvg: state.university!.internetAvg,
    //       locationAvg: state.university!.locationAvg,
    //       facilitiesAvg: state.university!.facilitiesAvg,
    //       foodAvg: state.university!.foodAvg,
    //       clubsAvg: state.university!.clubsAvg,
    //       favoriteAvg: state.university!.favoriteAvg,
    //       competitionLevelAvg: state.university!.competitionLevelAvg,
    //       totalReviews: state.university!.totalReviews,
    //       status: resUni.status,
    //     );
    //     emit(state.copyWith(
    //       university: newUni,
    //       status: DashboardUniversityStatus.success,
    //     ));
    //   } else {
    //     emit(state.copyWith(
    //       status: DashboardUniversityStatus.error,
    //       errorMessage: res.errorMessage,
    //     ));
    //   }
    // }
  }

  void deleteProfessor() async {
    // if (state.university != null) {
    //   emit(state.copyWith(
    //     status: DashboardUniversityStatus.loading,
    //   ));
    //
    //   final res = await _adminRepository.deleteUniversity(state.university!);
    //   if (res.isSuccess) {
    //     emit(const DashboardUniversityItemState(
    //       status: DashboardUniversityStatus.success,
    //       university: null,
    //     ));
    //   } else {
    //     emit(state.copyWith(
    //       status: DashboardUniversityStatus.error,
    //       errorMessage: res.errorMessage,
    //     ));
    //   }
    // }
  }
}
