import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:template/src/models/response/contact.dart';
import 'package:template/src/models/response/professor.dart';
import 'package:template/src/models/response/profile.dart';
import 'package:template/src/models/response/report.dart';
import 'package:template/src/models/response/search_response.dart';
import '../../models/response/university.dart';
import '../../repositories/dashboard_repository.dart';
import '../dashboard_root_screen.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _adminRepository;

  DashboardCubit(this._adminRepository) : super(const DashboardState());

  void onPageChange(DashboardPage page) {
    emit(state.copyWith(page: page.type));
    switch (state.page) {
      case DashboardPages.user:
        getAllAccounts();
        break;
      case DashboardPages.university:
        getAllUniversities();
        break;
      case DashboardPages.report:
        getAllReports();
        break;
      case null:
        break;
      case DashboardPages.contact:
        getAllContacts();
        break;
      case DashboardPages.professor:
        getAllProfessor();
        break;
    }
  }

  void onRefresh(){
    switch (state.page) {
      case DashboardPages.user:
        getAllAccounts(isRefresh: true);
        break;
      case DashboardPages.university:
        getAllUniversities(isRefresh: true);
        break;
      case DashboardPages.report:
        getAllReports(isRefresh: true);
        break;
      case null:
        break;
      case DashboardPages.contact:
        getAllContacts(isRefresh: true);
        break;
      case DashboardPages.professor:
        getAllProfessor(isRefresh: true);
        break;
    }
  }

  getAllProfessor({bool isRefresh = false}) async {
    if (!isRefresh) {
      if ((state.professors ?? []).isNotEmpty) return;
    }
    emit(state.copyWith(status: DashboardStatus.loading));
    final List<Professor> professors = [];
    final res = await _adminRepository.getProfessor('', 0, pageSize: 1000000);
    if (res.isSuccess) {
      professors.addAll((res.data as SearchProfessorModel).professores);
      emit(state.copyWith(
        status: DashboardStatus.success,
        professors: professors,
      ));
    } else {
      emit(state.copyWith(
        status: DashboardStatus.error,
        professors: [],
      ));
    }
  }

  getAllUniversities({bool isRefresh = false}) async {
    if (!isRefresh) {
      if ((state.universities ?? []).isNotEmpty) return;
    }
    emit(state.copyWith(status: DashboardStatus.loading));
    final List<University> universities = [];
    final res = await _adminRepository.getUniversities('', 0, pageSize: 1000);
    if (res.isSuccess) {
      universities.addAll((res.data as SearchModel).universities);
      emit(state.copyWith(
        status: DashboardStatus.success,
        universities: universities,
      ));
    } else {
      emit(state.copyWith(
        status: DashboardStatus.error,
        universities: [],
      ));
    }
  }

  getAllContacts({bool isRefresh = false}) async {
    if (!isRefresh) {
      if ((state.contacts ?? []).isNotEmpty) return;
    }
    emit(state.copyWith(status: DashboardStatus.loading));
    final List<Contact> contacts = [];
    final res = await _adminRepository.getContacts();
    if (res.isSuccess) {
      contacts.addAll(res.data as List<Contact>);
      emit(state.copyWith(
        status: DashboardStatus.success,
        contacts: contacts,
      ));
    } else {
      emit(state.copyWith(
        status: DashboardStatus.error,
        contacts: [],
      ));
    }
  }

  getAllAccounts({bool isRefresh = false}) async {
    if (!isRefresh) {
      if ((state.accounts ?? []).isNotEmpty) return;
    }
    emit(state.copyWith(status: DashboardStatus.loading));
    final List<Profile> accounts = [];
    final res = await _adminRepository.getAccounts();
    if (res.isSuccess) {
      accounts.addAll(res.data as List<Profile>);
      emit(state.copyWith(
        status: DashboardStatus.success,
        accounts: accounts,
      ));
    } else {
      emit(state.copyWith(
        status: DashboardStatus.error,
        accounts: [],
      ));
    }
  }

  getAllReports({bool isRefresh = false}) async {
    if (!isRefresh) {
      if ((state.reports ?? []).isNotEmpty) return;
    }
    emit(state.copyWith(status: DashboardStatus.loading));
    final List<Report> reports = [];
    final res = await _adminRepository.getReports();
    if (res.isSuccess) {
      reports.addAll(res.data as List<Report>);
      emit(state.copyWith(
        status: DashboardStatus.success,
        reports: reports,
      ));
    } else {
      emit(state.copyWith(
        status: DashboardStatus.error,
        reports: [],
      ));
    }
  }
}
