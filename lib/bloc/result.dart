import 'package:flutter/foundation.dart';

import '../models/thing.dart';

@immutable
abstract class SearchResult {
  const SearchResult();
}

@immutable
class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}

@immutable
class SearchResultEmpty implements SearchResult {
  const SearchResultEmpty();
}

@immutable
class SearchResultError implements SearchResult {
  final String error;
  const SearchResultError({required this.error});
}

@immutable
class SearchResultSuccess implements SearchResult {
  final List<Thing> result;

  const SearchResultSuccess({required this.result});
}
