import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/contact.dart';
import '../../../repositories/dashboard_repository.dart';

part 'dashboard_contact_item_state.dart';

@injectable
class DashboardContactItemCubit extends Cubit<DashboardContactItemState> {
  final DashboardRepository _adminRepository;

  DashboardContactItemCubit(this._adminRepository)
      : super(const DashboardContactItemState());

  void getContact(Contact contact) {
    emit(state.copyWith(contact: contact));
  }

  void resolvedContact(Contact contactResolved) async {
    if (state.contact != null) {
      emit(state.copyWith(
        status: DashboardContactStatus.loading,
      ));

      final res = await _adminRepository.resolveContacts(contactResolved);
      if (res.isSuccess) {
        emit(state.copyWith(
          status: DashboardContactStatus.success,
          contact: res.data as Contact
        ));
      } else {
        emit(state.copyWith(
          status: DashboardContactStatus.error,
          errorMessage: res.errorMessage,
        ));
      }
    }
  }
}
