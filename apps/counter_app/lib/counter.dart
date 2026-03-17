import 'package:riverpod/riverpod.dart';
import 'package:shared_repos/shared_repos.dart';

final stopwatchRepoProvider = Provider<StopwatchRepo>((ref) {
  final repo = StopwatchRepo();
  ref.onDispose(repo.dispose);
  return repo;
});

final persistenceRepoProvider = Provider<MockPersistenceRepo>((ref) {
  final repo = MockPersistenceRepo();
  ref.onDispose(repo.dispose);
  return repo;
});

class CounterNotifier extends Notifier<int> {
  late final StopwatchRepo _repo = ref.read(stopwatchRepoProvider);

  @override
  int build() {
    _repo.start();
    ref.onDispose(_repo.stop);
    return 0;
  }

  void increment() => state++;

  Future<void> persist() async {
    final repo = ref.read(persistenceRepoProvider);
    await repo.write('counter', state);
    if (!ref.mounted) return; // Guard disposal after async work.
  }
}

final counterProvider = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
