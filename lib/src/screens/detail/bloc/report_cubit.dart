import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/report_request.dart';
import 'package:template/src/models/response/university_review.dart';

import '../../../repositories/detail_repository.dart';

part 'report_state.dart';

@injectable
class ReportCubit extends Cubit<ReportState> {
  final DetailRepository _detailRepository;

  ReportCubit(this._detailRepository) : super(const ReportState());

  void reportReview(UniversityReview review, String reason) async {
    final ReportRaw report = ReportRaw(
      reportReason: reason,
      reviewId: review.id,
    );
    emit(state.copyWith(status: ReportStatus.loading));
    try {
      final isSuccess = await _detailRepository.reportReview(report);
      if(isSuccess) {
        emit(state.copyWith(status: ReportStatus.success));
      } else {
        emit(state.copyWith(status: ReportStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: ReportStatus.error));
    }
  }

  void updateReason(String reason){
    emit(state.copyWith(reason: reason));
  }
}
