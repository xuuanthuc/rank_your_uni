import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../models/response/tag.dart';
import '../../../repositories/dashboard_repository.dart';

part 'dashboard_tags_state.dart';

@injectable
class DashboardTagsCubit extends Cubit<DashboardTagsState> {
  final DashboardRepository _adminRepository;

  DashboardTagsCubit(this._adminRepository)
      : super(const DashboardTagsState());

  void addNewTag(String label) async {
    final res = await _adminRepository.addNewTag(label);
    if (res.isSuccess) {
      emit(state.copyWith(
        status: DashboardTagStatus.success,
      ));
    } else {
      emit(state.copyWith(
        status: DashboardTagStatus.error,
      ));
    }
  }
}
