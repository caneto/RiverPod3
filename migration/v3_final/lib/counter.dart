import 'package:riverpod/riverpod.dart';
import 'package:shared_repos/shared_repos.dart';

final stopwatchRepoProvider = Provider<StopwatchRepo>((ref) {
  final repo = StopwatchRepo();
  ref.onDispose(repo.dispose);
  return repo;
});

final counterProvider = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class CounterNotifier extends Notifier<int> {
  late final StopwatchRepo _repo;

  @override
  int build() {
    _repo = ref.read(stopwatchRepoProvider);
    _repo.start();
    ref.onDispose(_repo.stop);
    return 0;
  }

  void increment() => state++;
}
