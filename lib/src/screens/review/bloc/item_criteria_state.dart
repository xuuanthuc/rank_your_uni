part of 'item_criteria_cubit.dart';

enum MouseStatus { hover, none }

@immutable
class ItemCriteriaState extends Equatable {
  final MouseStatus? status;
  final int? indexHover;
  final CriteriaRated? rated;

  const ItemCriteriaState({
    this.status,
    this.indexHover,
    this.rated,
  });

  ItemCriteriaState copyWith({
    MouseStatus? status,
    int? indexHover,
    CriteriaRated? rated,
  }) {
    return ItemCriteriaState(
      status: status,
      indexHover: indexHover,
      rated: rated,
    );
  }

  @override
  List<Object?> get props => [
        status,
        indexHover,
        rated,
      ];
}

class CriteriaRated {
  final Criteria criteria;
  final RatePoint point;

  const CriteriaRated({
    required this.criteria,
    required this.point,
  });
}
