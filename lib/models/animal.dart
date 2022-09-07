import 'package:rx_dart_turbo/models/thing.dart';

enum AnimalType {
  dog,
  cat,
  wabbit,
  duck,
  unknown,
}

class Animal extends Thing {
  final AnimalType type;

  const Animal({required String name, required this.type})
      : super(
          name: name,
        );

  @override
  String toString() => 'Animal, name is $name, type is $type';

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      type: [
        AnimalType.values
            .where(
                (element) => element.toString().split('.')[1] == json['type'])
            .first,
        AnimalType.unknown
      ].first,
    );
  }
}
