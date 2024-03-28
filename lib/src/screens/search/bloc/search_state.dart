part of 'search_cubit.dart';

enum SearchStatus {
  init,
  loadingMore,
  success,
  error,
}

@immutable
class SearchState extends Equatable {
  final List<University>? universities;
  final List<Professor>? professores;
  final SearchStatus? status;
  final int? currentPage;
  final String? keyword;
  final SearchModel? searchModel;
  final SearchProfessorModel? searchProfessorModel;

  const SearchState({
    this.universities,
    this.status,
    this.currentPage,
    this.keyword,
    this.searchModel,
    this.professores,
    this.searchProfessorModel,
  });

  SearchState copyWith({
    List<University>? universities,
    SearchStatus? status,
    int? currentPage,
    String? keyword,
    SearchModel? searchModel,
    SearchProfessorModel? searchProfessorModel,
    List<Professor>? professores,
  }) {
    return SearchState(
      universities: universities ?? this.universities,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      searchModel: searchModel ?? this.searchModel,
      keyword: keyword ?? this.keyword,
      professores: professores ?? this.professores,
      searchProfessorModel: searchProfessorModel ?? this.searchProfessorModel,
    );
  }

  @override
  List<Object?> get props => [
        universities,
        status,
        currentPage,
        keyword,
        searchModel,
      ];
}
