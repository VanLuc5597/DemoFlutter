import 'package:demo_riverpod_hooks/example5/dialog_info_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data_model.dart';

class UserInfoExample extends ConsumerWidget {
  const UserInfoExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
              itemCount: dataModel.count,
              itemBuilder: (context, index) {
                final person = dataModel.people[index];
                return ListTile(
                    title: GestureDetector(
                  onTap: () async {
                    final updatePerson =
                        await createOrUpdatePersonDialog(context, person);
                    if (updatePerson != null) {
                      dataModel.updatePerson(updatePerson);
                    }
                  },
                  child: Text(person.displayPerson),
                ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(context);
          if (person != null) {
            final dataModel = ref.watch(peopleProvider);
            dataModel.addPerson(person);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
