// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

enum ThingType {
  animal,
  person,
}

@immutable
class Thing {
  final String name;
  final ThingType type;
  const Thing({
    required this.name,
    required this.type,
  });
}
