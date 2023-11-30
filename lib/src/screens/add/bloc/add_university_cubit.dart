import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/response/province.dart';
import '../../../models/request/add_university_request.dart';

part 'add_university_state.dart';

@injectable
class AddUniversityCubit extends Cubit<AddUniversityState> {
  AddUniversityCubit() : super(const AddUniversityState());

  void onSelectedProvinceDistrict(Province province, Districts districts) {
    emit(state.copyWith(status: AddUniStatus.loading));
    emit(state.copyWith(
      addUniversityRaw: (state.addUniversityRaw ?? AddUniversityRaw())
        ..province = province
        ..districts = districts,
      status: AddUniStatus.success,
    ));
  }

  void onCheckPrivacy() {
    emit(state.copyWith(acceptPrivacy: !(state.acceptPrivacy ?? false)));
  }
}