part of 'dashboard_authentication_cubit.dart';

enum DashboardAuthenticationStatus { loading, success, error }

@immutable
class DashboardAuthenticationState extends Equatable {
  final DashboardAuthenticationStatus? status;
  final String? errorMessage;
  final bool? isHovering;

  const DashboardAuthenticationState({
    this.status,
    this.errorMessage,
    this.isHovering,
  });

  DashboardAuthenticationState copyWith({
    DashboardAuthenticationStatus? status,
    String? errorMessage,
    bool? isHovering,
  }) {
    return DashboardAuthenticationState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      isHovering: isHovering ?? this.isHovering,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        isHovering,
      ];
}
