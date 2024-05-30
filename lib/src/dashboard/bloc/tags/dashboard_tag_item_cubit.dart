import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../models/response/tag.dart';
import '../../../repositories/dashboard_repository.dart';

part 'dashboard_tag_item_state.dart';

@injectable
class DashboardTagItemCubit extends Cubit<DashboardTagItemState> {
  final DashboardRepository _adminRepository;

  DashboardTagItemCubit(this._adminRepository)
      : super(const DashboardTagItemState());

  void getTag(Tag tag) {
    emit(state.copyWith(tag: tag));
  }
}
