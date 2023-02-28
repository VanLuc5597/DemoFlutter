import 'dart:collection';

import 'package:demo_riverpod_hooks/example5/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];

  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void addPerson(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void removePerson(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void updatePerson(Person person) {
    final index = _people.indexOf(person);
    final oldPerson = _people[index];
    if (oldPerson.name != person.name || oldPerson.age != person.age) {
      _people[index] = oldPerson.updated(person.name, person.age);
      notifyListeners();
    }
  }

}

final peopleProvider = ChangeNotifierProvider((ref) => DataModel());
