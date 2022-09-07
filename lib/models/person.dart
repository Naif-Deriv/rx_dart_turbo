import 'package:rx_dart_turbo/models/thing.dart';

class Person extends Thing {
  final int age;

  const Person({required String name, required this.age})
      : super(
          name: name,
        );

  @override
  String toString() => 'Person, name is $name, age is $age';

  factory Person.fromJson(Map<String, dynamic> json) =>
      Person(name: json['name'], age: json['age']);
}
