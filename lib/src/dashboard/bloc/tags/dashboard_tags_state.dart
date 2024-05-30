part of 'dashboard_tags_cubit.dart';

enum DashboardTagStatus { loading, success, error }

@immutable
class DashboardTagsState extends Equatable {
  final DashboardTagStatus? status;
  final Tag? tag;

  const DashboardTagsState({
    this.status,
    this.tag,
  });

  DashboardTagsState copyWith({
    DashboardTagStatus? status,
    Tag? tag,
  }) {
    return DashboardTagsState(
      status: status ?? this.status,
      tag: tag ?? this.tag,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tag,
      ];
}
