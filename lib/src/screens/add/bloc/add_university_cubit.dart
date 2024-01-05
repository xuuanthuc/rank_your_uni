import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/province.dart';
import '../../../models/request/add_university_request.dart';
import '../../../repositories/detail_repository.dart';

part 'add_university_state.dart';

@injectable
class AddUniversityCubit extends Cubit<AddUniversityState> {
  final DetailRepository _detailRepository;

  AddUniversityCubit(this._detailRepository)
      : super(const AddUniversityState());

  void onSelectedProvinceDistrict(Province province, Districts districts) {
    emit(state.copyWith(status: AddUniStatus.loading));
    emit(state.copyWith(
      addUniversityRaw: (state.addUniversityRaw ?? AddUniversityRaw())
        ..province = province
        ..districts = districts,
      status: AddUniStatus.changed,
    ));
  }

  void onCheckPrivacy() {
    emit(state.copyWith(
      acceptPrivacy: !(state.acceptPrivacy ?? false),
      status: AddUniStatus.changed,
    ));
  }

  void clearAll() {
    emit(const AddUniversityState());
  }

  void submitAddUniversity({
    required String name,
    required String website,
    required String code,
  }) async {
    if (state.acceptPrivacy != true) return;
    emit(state.copyWith(
      status: AddUniStatus.loading,
      addUniversityRaw: state.addUniversityRaw
        ?..code = code
        ..website = website
        ..name = name
        ..status = 0,
    ));
    if (state.addUniversityRaw == null) return;
    final result =
        await _detailRepository.addUniversity(state.addUniversityRaw!);
    if (result.isSuccess) {
      emit(state.copyWith(status: AddUniStatus.success));
    } else {
      emit(state.copyWith(status: AddUniStatus.error));
    }
  }
}
