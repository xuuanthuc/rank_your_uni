import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:template/global/utilities/logger.dart';
import '../../../models/response/university.dart';
import '../../../repositories/search_repository.dart';

part 'autocompletion_state.dart';

const Duration debounceDuration = Duration(milliseconds: 1000);

@injectable
class AutocompletionCubit extends Cubit<AutocompletionState> {
  final SearchRepository _searchRepository;
  late final _Debounceable<Iterable<University>?, String> _debouncedSearch;

  AutocompletionCubit(this._searchRepository)
      : super(const AutocompletionState()) {
    _debouncedSearch = _debounce<Iterable<University>?, String>(_searchUni);
  }

  Future<Iterable<University>?> _searchUni(String keyword) async {
    if (keyword.length < 3) return [];
    final res = await _searchRepository.getUniversities(
      keyword,
      0,
      pageSize: 5,
    );
    if (res.isSuccess) {
      return res.data.universities;
    } else {
      return [];
    }
  }

  Future<Iterable<University>> getSuggestUniversity(String keyword) async {
    try {
      final data = await _debouncedSearch(keyword);
      if (data!.toList().isNotEmpty) {
        return data.toList();
      }
    } catch (e) {
      LoggerUtils.d(e);
    }
    return [];
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}
