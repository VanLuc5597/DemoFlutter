import 'package:demo_riverpod_hooks/weather_example_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'contact_example_widget.dart';
import 'example5/info_user_example.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserInfoExample());
  }
}

final currentDate = Provider((ref) => (DateTime.now));

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);

  void increment() => state = state == null ? 1 : state + 1;

  int? get value => state;
}

final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              onPressed: () {
                ref.read(counterProvider.notifier).increment();
              },
              child: const Text('Click here to increment')),
          Text('${counter}')
        ],
      ),
    );
  }
}
