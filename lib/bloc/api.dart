import 'dart:convert';
import 'dart:io';

import 'package:rx_dart_turbo/models/person.dart';

import '../models/animal.dart';
import '../models/thing.dart';

class API {
  List<Animal>? animals;
  List<Person>? people;
  API();

  Future<List<Thing>> search(String searchTerm) async {
    final cachedResults = getCachedValue(searchTerm);
    if (cachedResults != null) {
      return cachedResults;
    } else {
      final jsonAnimals =
          await _getJson('http://127.0.0.1:5500/json/animals.json');
      final jsonPeople =
          await _getJson('http://127.0.0.1:5500/json/people.json');

      final peopleList = jsonPeople.map((e) => Person.fromJson(e)).toList();
      final animalList = jsonAnimals.map((e) => Animal.fromJson(e)).toList();

      animals = animalList;
      people = peopleList;

      return getCachedValue(searchTerm) ?? [];
    }
  }

  List<Thing>? getCachedValue(String searchTerm) {
    final cachedAnimals = animals;
    final cachedPeople = people;

    List<Thing> res = [];

    if (cachedPeople != null && cachedAnimals != null) {
      for (Animal animal in cachedAnimals) {
        if (animal.name.isMatching(searchTerm) ||
            animal.type.name.isMatching(searchTerm)) {
          res.add(animal);
        }
      }
      for (Person person in cachedPeople) {
        if (person.name.isMatching(searchTerm) ||
            person.age.toString().isMatching(searchTerm)) {
          res.add(person);
        }
      }
      return res;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> _getJson(String url) async {
    return await HttpClient()
        .getUrl(Uri.parse(url))
        .then((req) => req.close())
        .then((res) => res.transform(utf8.decoder).join())
        .then((jsonResponse) => json.decode(jsonResponse) as List<dynamic>);
  }
}

extension Match on String {
  bool isMatching(String other) => trim().toLowerCase().contains(
        other.trim().toLowerCase(),
      );
}
