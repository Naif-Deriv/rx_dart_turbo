import 'package:flutter/material.dart';
import 'package:rx_dart_turbo/bloc/filter_bloc.dart';
import 'package:rx_dart_turbo/models/thing.dart';

const things = [
  Thing(name: 'Foo', type: ThingType.animal),
  Thing(name: 'Tag', type: ThingType.animal),
  Thing(name: 'Buzz', type: ThingType.animal),
  Thing(name: 'Lucky', type: ThingType.animal),
  Thing(name: 'Yara', type: ThingType.person),
  Thing(name: 'Naif', type: ThingType.person),
  Thing(name: 'Mr.Potato', type: ThingType.person),
  Thing(name: 'Hilary', type: ThingType.person),
];

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final FilterBloc filterBloc;
  @override
  void initState() {
    filterBloc = FilterBloc(thingsList: things);
    super.initState();
  }

  @override
  void dispose() {
    filterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Chip with Rx'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder<ThingType?>(
              stream: filterBloc.chosenThingType,
              builder: (context, snapshot) {
                return Wrap(
                  children: ThingType.values
                      .map(
                        (type) => FilterChip(
                          selectedColor: Colors.blueGrey,
                          onSelected: (isChosen) {
                            filterBloc.thingTypeSink
                                .add(isChosen ? type : null);
                          },
                          label: Text(type.toString()),
                          selected: snapshot.data == type,
                        ),
                      )
                      .toList(),
                );
              },
            ),
            Expanded(
              child: StreamBuilder<Iterable<Thing>>(
                stream: filterBloc.things,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    itemBuilder: (context, index) => Text(
                      snapshot.data!.elementAt(index).name,
                    ),
                  );
                },
              ),
            ),
            const TextField(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
