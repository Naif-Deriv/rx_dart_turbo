import 'package:flutter/material.dart';
import 'package:rx_dart_turbo/bloc/search_bloc.dart';
import 'package:rx_dart_turbo/views/search_result_view.dart';

import '../bloc/api.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final SearchBloc searchBloc;

  @override
  void initState() {
    searchBloc = SearchBloc(api: API());
    super.initState();
  }

  @override
  void dispose() {
    searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: searchBloc.search.add,
            ),
            const SizedBox(
              height: 25,
            ),
            SearchResultView(
              searchResult: searchBloc.result,
            ),
          ],
        ),
      ),
    );
  }
}
