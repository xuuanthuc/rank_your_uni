import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'appbar_state.dart';

@injectable
class AppbarCubit extends Cubit<AppbarState> {
  AppbarCubit() : super(const AppbarState(onShowSmallTextField: false));

  changeSmallTextFieldState() {
    emit(state.copyWith(
      onShowSmallTextField: !(state.onShowSmallTextField ?? false),
      status: AppbarStatus.searchField,
    ));
  }
}
