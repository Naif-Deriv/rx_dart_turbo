import 'package:flutter/material.dart';
import 'package:rx_dart_turbo/bloc/bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final TextfieldBloc textBloc;
  @override
  void initState() {
    textBloc = TextfieldBloc();
    super.initState();
  }

  @override
  void dispose() {
    textBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First & Last names...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            StreamBuilder(
              stream: textBloc.fullName,
              builder: (_, snapshot) => Column(
                children: [
                  TextField(
                    onChanged: textBloc.firstName.add,
                  ),
                  TextField(
                    onChanged: textBloc.lastName.add,
                  ),
                  const SizedBox(height: 42),
                  Text(
                    snapshot.data.toString(),
                    style: const TextStyle(
                      fontSize: 42,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
