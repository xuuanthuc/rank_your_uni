part of 'dashboard_tag_item_cubit.dart';

enum DashboardTagItemStatus { loading, success, error }

@immutable
class DashboardTagItemState extends Equatable {
  final DashboardTagItemStatus? status;
  final Tag? tag;

  const DashboardTagItemState({
    this.status,
    this.tag,
  });

  DashboardTagItemState copyWith({
    DashboardTagItemStatus? status,
    Tag? tag,
  }) {
    return DashboardTagItemState(
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
