import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/profile.dart';
import '../../../repositories/dashboard_repository.dart';

part 'dashboard_account_item_state.dart';

@injectable
class DashboardAccountItemCubit extends Cubit<DashboardAccountItemState> {
  final DashboardRepository _adminRepository;

  DashboardAccountItemCubit(this._adminRepository)
      : super(const DashboardAccountItemState());

  void getAccount(Profile account) {
    emit(state.copyWith(account: account));
  }
}
