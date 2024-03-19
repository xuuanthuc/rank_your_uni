import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:template/src/models/response/contact.dart';
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
        break;
      case DashboardPages.university:
        getAllUniversities();
        break;
      case DashboardPages.report:
        break;
      case null:
        break;
      case DashboardPages.contact:
        getAllContacts();
        break;
    }
  }

  getAllUniversities() async {
    if ((state.universities ?? []).isNotEmpty) return;
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

  getAllContacts() async {
    if ((state.contacts ?? []).isNotEmpty) return;
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
        universities: [],
      ));
    }
  }
}
