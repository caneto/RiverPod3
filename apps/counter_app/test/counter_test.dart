import 'package:counter_app/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_repos/shared_repos.dart';

void main() {
  test('stopwatch repo restarts when notifier rebuilds', () {
    final fakeRepo = _FakeStopwatchRepo();
    final container = ProviderContainer(overrides: [
      stopwatchRepoProvider.overrideWithValue(fakeRepo),
    ]);
    addTearDown(container.dispose);

    container.read(counterProvider);
    expect(fakeRepo.startCalls, 1);

    container.invalidate(counterProvider);
    container.read(counterProvider);

    expect(fakeRepo.startCalls, 2);
  });
}

class _FakeStopwatchRepo extends StopwatchRepo {
  int startCalls = 0;

  @override
  void start() {
    startCalls++;
  }

  @override
  Duration get elapsed => Duration.zero;

  @override
  void stop() {}

  @override
  void dispose() {}
}
