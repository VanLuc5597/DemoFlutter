import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactExampleWidget extends ConsumerWidget {
  const ContactExampleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
        ),
        body: name.when(
            data: (names) {
              return ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(names.elementAt(index)),
                    );
                  });
            },
            error: (error, stackTrace) =>
                const Text('Reached the end of the list'),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}

final tickerProvider = StreamProvider(
    (ref) => Stream.periodic(const Duration(seconds: 1), (i) => i + 1));

final nameProvider = StreamProvider((ref) =>
    ref.watch(tickerProvider.stream).map((event) => names.getRange(0, event)));

const names = [
  'Lực 11',
  'Lực 12',
  'Lực 13',
  'Lực 14',
  'Lực 15',
  'Lực 16',
  'Lực 17',
  'Lực 18',
  'Lực 19',
  'Lực 20',
];
