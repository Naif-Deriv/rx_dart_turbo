import 'package:flutter/foundation.dart';
import 'package:rx_dart_turbo/bloc/result.dart';
import 'package:rxdart/rxdart.dart';

import 'api.dart';

@immutable
class SearchBloc {
  final Sink<String> search;
  final Stream<SearchResult?> result;

  const SearchBloc._({required this.search, required this.result});

  void dispose() {
    search.close();
  }

  factory SearchBloc({required API api}) {
    final textChanges = BehaviorSubject<String>();

    final results = textChanges
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(
      (String userInput) {
        if (userInput.isEmpty) {
          return Stream<SearchResult?>.value(null);
        } else {
          return Rx.fromCallable(() => api.search(userInput))
              .delay(const Duration(seconds: 1))
              .map(
                (apiResult) => apiResult.isEmpty
                    ? const SearchResultEmpty()
                    : SearchResultSuccess(result: apiResult),
              )
              .startWith(const SearchResultLoading())
              .onErrorReturn(
                const SearchResultError(error: 'Error has occured'),
              );
        }
      },
    );

    return SearchBloc._(search: textChanges.sink, result: results);
  }
}
