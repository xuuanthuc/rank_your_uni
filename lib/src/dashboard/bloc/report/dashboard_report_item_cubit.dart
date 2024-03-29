import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/report.dart';

import '../../../repositories/dashboard_repository.dart';

part 'dashboard_report_item_state.dart';

@injectable
class DashboardReportItemCubit extends Cubit<DashboardReportItemState> {
  final DashboardRepository _adminRepository;

  DashboardReportItemCubit(this._adminRepository)
      : super(const DashboardReportItemState());

  void getReport(Report report) {
    emit(state.copyWith(report: report));
  }

  void deleteReport() async {
    if (state.report == null) return;
    emit(state.copyWith(status: DashboardReportStatus.loading));
    final res = await _adminRepository.deleteReport(state.report!);
    if (res.isSuccess) {
      emit(state.copyWith(status: DashboardReportStatus.success));
    } else {
      emit(state.copyWith(status: DashboardReportStatus.error));
    }
  }

  void deleteReview(int id) async {
    emit(state.copyWith(
      status: DashboardReportStatus.loading,
    ));
    final res = await _adminRepository.deleteReview(id);
    if (res.isSuccess) {
      emit(state.copyWith(status: DashboardReportStatus.success));
    } else {
      emit(state.copyWith(status: DashboardReportStatus.error));
    }
  }
}
