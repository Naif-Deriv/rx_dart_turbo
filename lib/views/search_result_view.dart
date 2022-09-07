import 'package:flutter/material.dart';
import 'package:rx_dart_turbo/bloc/result.dart';

class SearchResultView extends StatelessWidget {
  final Stream<SearchResult?> searchResult;
  const SearchResultView({required this.searchResult, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: searchResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data;
          if (result is SearchResultError) {
            return Text(result.error.toString());
          } else if (result is SearchResultLoading) {
            return const Text('Loading');
          } else if (result is SearchResultEmpty) {
            return const Text('No results found');
          } else if (result is SearchResultSuccess) {
            final results = result.result;
            return Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      results[index].toString(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Text('Unknown State!');
          }
        }
        return const Text('Please type something..');
      },
    );
  }
}
