import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter.dart';

void main() {
  runApp(const ProviderScope(child: CounterApp()));
}

class CounterApp extends ConsumerWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(counterProvider);
    final elapsed = ref.watch(stopwatchRepoProvider).elapsed;
    final persistence = ref.watch(persistenceRepoProvider);

    return MaterialApp(
      title: 'Notifier rebuild demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod 3 Counter')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Current value: $value', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text('Stopwatch elapsed: ${elapsed.inMilliseconds} ms', textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => ref.read(counterProvider.notifier).increment(),
                    icon: const Icon(Icons.add),
                    label: const Text('Increment (new Notifier API)'),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => ref.read(counterProvider.notifier).persist(),
                    icon: const Icon(Icons.save_alt),
                    label: const Text('Persist snapshot (experimental)'),
                  ),
                  const SizedBox(height: 24),
                  const Text('Persistence changelog'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 240,
                    child: StreamBuilder<Map<String, Object?>>(
                      stream: persistence.changes,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text('Press persist to store state.'));
                        }
                        final entries = snapshot.data!.entries.toList()
                          ..sort((a, b) => a.key.compareTo(b.key));
                        if (entries.isEmpty) {
                          return const Center(child: Text('Press persist to store state.'));
                        }
                        return ListView(
                          children: [
                            for (final entry in entries)
                              ListTile(
                                title: Text(entry.key),
                                subtitle: Text('${entry.value}'),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
