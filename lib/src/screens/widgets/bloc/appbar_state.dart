part of 'appbar_cubit.dart';

enum AppbarStatus { searchField }

@injectable
class AppbarState extends Equatable {
  final bool? onShowSmallTextField;
  final AppbarStatus? status;

  const AppbarState({this.onShowSmallTextField, this.status});

  AppbarState copyWith({bool? onShowSmallTextField, AppbarStatus? status}) {
    return AppbarState(
      onShowSmallTextField: onShowSmallTextField ?? this.onShowSmallTextField,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        onShowSmallTextField,
        status,
      ];
}
