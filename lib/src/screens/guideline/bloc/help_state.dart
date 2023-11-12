part of 'help_cubit.dart';

@immutable
class HelpState extends Equatable {
  final List<QuestionCategories>? categories;
  final int? currentCategory;
  final int? currentShowIndex;

  const HelpState({
    this.categories,
    this.currentCategory,
    this.currentShowIndex,
  });

  HelpState copyWith({
    List<QuestionCategories>? categories,
    int? currentCategory,
    int? currentShowIndex,
  }) {
    return HelpState(
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
  ];
}