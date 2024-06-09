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
        status: 1,
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

  void updateProfessor(UpdateProfessorRaw newProfessor) async {
    final professor = state.professor;
    if (professor != null) {
      emit(state.copyWith(
        status: DashboardProfessorStatus.loading,
      ));
      final res = await _adminRepository.updateProfessor(newProfessor);
      if (res.isSuccess) {
        final Professor resProfessor = res.data as Professor;
        final newProfessor = Professor(
          professor.id,
          fullName: resProfessor.fullName,
          university: resProfessor.university,
          major: resProfessor.major,
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

  void deleteProfessor() async {
    if (state.professor != null) {
      emit(state.copyWith(
        status: DashboardProfessorStatus.loading,
      ));

      final res = await _adminRepository.deleteProfessor(state.professor!);
      if (res.isSuccess) {
        emit(const DashboardProfessorItemState(
          status: DashboardProfessorStatus.success,
          professor: null,
        ));
      } else {
        emit(state.copyWith(
          status: DashboardProfessorStatus.error,
          errorMessage: res.errorMessage,
        ));
      }
    }
  }
}
