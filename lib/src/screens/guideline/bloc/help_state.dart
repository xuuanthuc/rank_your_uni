part of 'help_cubit.dart';

enum HelpStatus { loading, success, error }

@immutable
class HelpState extends Equatable {
  final List<QuestionCategories>? categories;
  final HelpStatus? status;
  final int? currentCategory;
  final int? currentShowIndex;

  const HelpState({
    this.categories,
    this.status,
    this.currentCategory,
    this.currentShowIndex,
  });

  HelpState copyWith({
    List<QuestionCategories>? categories,
    int? currentCategory,
    HelpStatus? status,
    int? currentShowIndex,
  }) {
    return HelpState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      currentCategory: currentCategory ?? this.currentCategory,
      currentShowIndex: currentShowIndex,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        currentCategory,
        currentShowIndex,
        status,
      ];
}
