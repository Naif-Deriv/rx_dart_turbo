import 'package:flutter/foundation.dart';
import 'package:rx_dart_turbo/models/thing.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class FilterBloc {
  final Sink<ThingType?> thingTypeSink;
  final Stream<ThingType?> chosenThingType;
  final Stream<Iterable<Thing>> things;

  const FilterBloc._({
    required this.thingTypeSink,
    required this.chosenThingType,
    required this.things,
  });

  factory FilterBloc({
    required Iterable<Thing> thingsList,
  }) {
    final thingTypesSubject = BehaviorSubject<ThingType?>();

    final filteredThings = thingTypesSubject
        .debounceTime(const Duration(milliseconds: 500))
        .map(
          (type) => type != null
              ? thingsList.where((element) => element.type == type)
              : thingsList,
        )
        .startWith(thingsList);

    return FilterBloc._(
      thingTypeSink: thingTypesSubject.sink,
      chosenThingType: thingTypesSubject.stream,
      things: filteredThings,
    );
  }

  void dispose() {
    thingTypeSink.close();
  }
}
