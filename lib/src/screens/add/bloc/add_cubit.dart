import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:template/src/models/request/add_professor_request.dart';
import 'package:template/src/models/response/province.dart';
import '../../../models/request/add_university_request.dart';
import '../../../repositories/detail_repository.dart';

part 'add_state.dart';

@injectable
class AddCubit extends Cubit<AddState> {
  final DetailRepository _detailRepository;

  AddCubit(this._detailRepository) : super(const AddState());

  void onSelectedProvinceDistrict(Province province, Districts districts) {
    emit(state.copyWith(status: AddStatus.loading));
    emit(state.copyWith(
      addUniversityRaw: (state.addUniversityRaw ?? AddUniversityRaw())
        ..province = province
        ..districts = districts,
      status: AddStatus.changed,
    ));
  }

  void onCheckPrivacy() {
    emit(state.copyWith(
      acceptPrivacy: !(state.acceptPrivacy ?? false),
      status: AddStatus.changed,
    ));
  }

  void clearAll() {
    emit(const AddState());
  }

  void submitAddUniversity({
    required String name,
    required String website,
    required String code,
  }) async {
    if (state.acceptPrivacy != true) return;
    emit(state.copyWith(
      status: AddStatus.loading,
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
      emit(state.copyWith(status: AddStatus.success));
    } else {
      emit(state.copyWith(
        status: AddStatus.error,
        message: result.errorMessage,
      ));
    }
  }

  void submitAddProfessor({
    required String name,
    required int universityId,
    required int majorId,
  }) async {
    if (state.acceptPrivacy != true) return;
    if (name.isEmpty || universityId == -1 || majorId == -1) {
      emit(state.copyWith(
        status: AddStatus.error,
        message: "Vui lòng điều đủ thông tin!",
      ));
      return;
    }
    emit(state.copyWith(status: AddStatus.loading));
    final AddProfessorRaw professor = AddProfessorRaw(
      majorId: majorId,
      schoolId: universityId,
      fullName: name,
    );
    final result = await _detailRepository.addProfessor(professor);
    if (result.isSuccess) {
      emit(state.copyWith(status: AddStatus.success));
    } else {
      emit(state.copyWith(
        status: AddStatus.error,
        message: result.errorMessage,
      ));
    }
  }
}
