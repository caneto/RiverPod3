import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_repos/shared_repos.dart';

void main() {
  runApp(const ProviderScope(child: StreamPauseApp()));
}

final tickerRepoProvider = Provider<TickerRepo>((ref) => TickerRepo());
final listenToggleProvider = NotifierProvider<ListenToggleNotifier, bool>(ListenToggleNotifier.new);
final tickStreamProvider = StreamProvider<int>((ref) {
  final ticker = ref.watch(tickerRepoProvider);
  return ticker.tick();
});

class StreamPauseApp extends ConsumerWidget {
  const StreamPauseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldListen = ref.watch(listenToggleProvider);
    final ticks = shouldListen ? ref.watch(tickStreamProvider) : const AsyncValue<int>.loading();

    return MaterialApp(
      title: 'Stream pause demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      home: Scaffold(
        appBar: AppBar(title: const Text('StreamProvider pause demo')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile.adaptive(
                title: const Text('Listen to tick stream'),
                subtitle: const Text('Toggle off to pause the subscription'),
                value: shouldListen,
                onChanged: (value) => ref.read(listenToggleProvider.notifier).update(value),
              ),
              const SizedBox(height: 24),
              Card(
                child: SizedBox(
                  height: 160,
                  child: Center(
                    child: shouldListen
                        ? ticks.when(
                            data: (value) => Text('Tick #$value', style: Theme.of(context).textTheme.displaySmall),
                            loading: () => const CircularProgressIndicator(),
                            error: (err, stack) => Text('Error: $err'),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.pause_circle_outline, size: 48),
                              const SizedBox(height: 8),
                              Text('Stream paused', style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                shouldListen
                    ? 'StreamProvider keeps the ticker alive while listening.'
                    : 'With no listeners, the ticker stream is paused to save resources.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListenToggleNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void update(bool value) => state = value;
}
