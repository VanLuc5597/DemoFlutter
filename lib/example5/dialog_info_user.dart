import 'package:demo_riverpod_hooks/example5/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

Future<Person?> createOrUpdatePersonDialog(BuildContext context,
    [Person? existPerson]) {
  String? name = existPerson?.name;
  int? age = existPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog<Person?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create a person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nhập tên'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Nhập tuổi'),
              onChanged: (value) => age = int.tryParse(value),
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                if (name != null && age != null) {
                  if (existPerson != null) {
                    final newPerson = existPerson.updated(name, age);
                    Navigator.of(context).pop(newPerson);
                  } else {
                    Navigator.of(context).pop(Person(name: name!, age: age!));
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'))
        ],
      );
    },
  );
}

final nameController = TextEditingController();
final ageController = TextEditingController();
