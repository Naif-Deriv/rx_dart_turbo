import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends HookWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final subject = useMemoized(
      () => BehaviorSubject<String>(),
      [key],
    );
    useEffect(
      () => subject.close,
      [subject],
    );
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            stream: subject.stream.debounceTime(const Duration(seconds: 1)),
            initialData: 'Please provide a title',
            builder: (context, snapshot) {
              return Text(snapshot.requireData.toString());
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: subject.sink.add,
        ),
      ),
    );
  }
}
