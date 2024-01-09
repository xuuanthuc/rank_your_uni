part of 'dashboard_authentication_cubit.dart';

enum DashboardAuthenticationStatus { loading, success, error }

@immutable
class DashboardAuthenticationState extends Equatable {
  final DashboardAuthenticationStatus? status;
  final String? errorMessage;
  final bool? isHovering;
  final VideoPlayerController? videoPlayerController;

  const DashboardAuthenticationState(
      {this.status,
      this.errorMessage,
      this.isHovering,
      this.videoPlayerController});

  DashboardAuthenticationState copyWith({
    DashboardAuthenticationStatus? status,
    VideoPlayerController? videoPlayerController,
    String? errorMessage,
    bool? isHovering,
  }) {
    return DashboardAuthenticationState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      isHovering: isHovering ?? this.isHovering,
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        isHovering,
        videoPlayerController,
      ];
}
