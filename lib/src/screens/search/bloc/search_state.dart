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
  final SearchStatus? status;

  const SearchState({this.universities, this.status});

  SearchState copyWith({List<University>? universities, SearchStatus? status}) {
    return SearchState(
      universities: universities ?? this.universities,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        universities,
        status,
      ];
}
