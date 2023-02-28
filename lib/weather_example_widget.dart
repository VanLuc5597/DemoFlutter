import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentCityProvider = StateProvider<City?>((ref) => City.vietnam);

final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return 'Unknown Weather';
  }
});

class WeatherExample extends ConsumerWidget {
  const WeatherExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          currentWeather.when(
              data: (data) => Text(
                    data,
                    style: const TextStyle(fontSize: 40),
                  ),
              error: (_, __) => const Text(
                    'Error',
                    style: TextStyle(fontSize: 40),
                  ),
              loading: () => const CircularProgressIndicator()),
          Expanded(
              child: ListView.builder(
                  itemCount: City.values.length,
                  itemBuilder: (context, index) {
                    final city = City.values[index];
                    final isSelected = city == ref.watch(currentCityProvider);
                    return ListTile(
                      title: Text(city.toString()),
                      trailing: isSelected ? const Icon(Icons.check) : null,
                      onTap: () {
                        ref.read(currentCityProvider.notifier).state = city;
                      },
                    );
                  }))
        ],
      ),
    );
  }
}

enum City { vietnam, paris, tokyo }

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
      const Duration(seconds: 1),
      () =>
          {
            City.vietnam: 'Nắng',
            City.paris: 'Mưa',
            City.tokyo: 'Tuyết'
          }[city] ??
          'Empty');
}
