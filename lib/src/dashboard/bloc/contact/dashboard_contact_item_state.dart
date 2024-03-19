part of 'dashboard_contact_item_cubit.dart';

enum DashboardContactStatus { loading, success, error }

@immutable
class DashboardContactItemState extends Equatable {
  final DashboardContactStatus? status;
  final String? errorMessage;
  final Contact? contact;

  const DashboardContactItemState({
    this.status,
    this.errorMessage,
    this.contact,
  });

  DashboardContactItemState copyWith(
      {DashboardContactStatus? status,
      String? errorMessage,
      bool? isHovering,
      Contact? contact}) {
    return DashboardContactItemState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      contact: contact ?? this.contact,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        contact,
      ];
}
