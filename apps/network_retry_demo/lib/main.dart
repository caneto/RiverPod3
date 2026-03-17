import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_repos/shared_repos.dart';

void main() {
  runApp(const ProviderScope(child: NetworkRetryApp()));
}

final retryToggleProvider = NotifierProvider<RetryToggleNotifier, bool>(RetryToggleNotifier.new);
final disableForUserProvider = NotifierProvider<DisableForUserNotifier, bool>(DisableForUserNotifier.new);
final retryLoggerProvider = Provider<RetryLogger>((ref) {
  final logger = RetryLogger();
  ref.onDispose(logger.dispose);
  return logger;
});

final userFutureProvider = FutureProvider.autoDispose<String>((ref) async {
    final enableRetry = ref.watch(retryToggleProvider);
    final disableForThis = ref.watch(disableForUserProvider);
  final logger = ref.watch(retryLoggerProvider);
  final service = _FlakyUserService(logger: logger);

  if (!enableRetry || disableForThis) {
    return service.fetchUser();
  }

  const maxAttempts = 3;
  for (var attempt = 0; attempt < maxAttempts; attempt++) {
    try {
      logger.recordAttempt();
      return await service.fetchUser();
    } catch (err) {
      if (attempt == maxAttempts - 1) rethrow;
      await Future.delayed(Duration(milliseconds: 200 * pow(2, attempt).toInt()));
    }
  }
  throw StateError('Unreachable');
});

class NetworkRetryApp extends ConsumerWidget {
  const NetworkRetryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userFutureProvider);
    final logger = ref.watch(retryLoggerProvider);
    final attempts = logger.events;

    return MaterialApp(
      title: 'Retry strategy demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod 3 Retry Demo')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Enable global retry'),
                    selected: ref.watch(retryToggleProvider),
                    onSelected: (value) => ref.read(retryToggleProvider.notifier).update(value),
                  ),
                  FilterChip(
                    label: const Text('Disable for this provider'),
                    selected: ref.watch(disableForUserProvider),
                    onSelected: (value) => ref.read(disableForUserProvider.notifier).update(value),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => ref.invalidate(userFutureProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Fetch user'),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: asyncUser.when(
                  data: (value) => Text('Loaded user: $value'),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Text('Error: $err'),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Retry attempts'),
              Expanded(
                child: StreamBuilder<RetryLogEntry>(
                  stream: attempts,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('Tap "Fetch user" to start');
                    }
                    return Text('Last attempt #${snapshot.data!.attempt} at ${snapshot.data!.timestamp.toIso8601String()}');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlakyUserService {
  _FlakyUserService({required this.logger});

  final RetryLogger logger;
  int _failureCount = 0;

  Future<String> fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_failureCount < 1) {
      _failureCount++;
      throw Exception('Simulated network error');
    }
    return 'Riverpod Fan';
  }
}

class RetryToggleNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void update(bool value) => state = value;
}

class DisableForUserNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void update(bool value) => state = value;
}
