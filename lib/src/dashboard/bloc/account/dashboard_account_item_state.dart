part of 'dashboard_account_item_cubit.dart';

enum DashboardAccountStatus { loading, success, error }

@immutable
class DashboardAccountItemState extends Equatable {
  final DashboardAccountStatus? status;
  final String? errorMessage;
  final Profile? account;

  const DashboardAccountItemState({
    this.status,
    this.errorMessage,
    this.account,
  });

  DashboardAccountItemState copyWith(
      {DashboardAccountStatus? status,
      String? errorMessage,
      bool? isHovering,
      Profile? account}) {
    return DashboardAccountItemState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      account: account ?? this.account,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        account,
      ];
}
