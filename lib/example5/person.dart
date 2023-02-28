import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({required this.name, required this.age, String? uuid})
      : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) =>
      Person(name: name ?? this.name, age: age ?? this.age, uuid: uuid);

  String get displayPerson => '$name with age : $age';

  @override
  bool operator == (covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() {
    return 'Person{name: $name, age: $age, uuid: $uuid}';
  }
}
