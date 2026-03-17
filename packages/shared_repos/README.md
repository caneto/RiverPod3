# Shared Repos Package

## Contents
- `StopwatchRepo`: wraps `Stopwatch` lifecycle, exposed via providers.
- `TickerRepo`: produces a periodic tick stream used in the stream pause demo.
- `RetryLogger`: emits retry attempts as a broadcast stream.
- `MockPersistenceRepo`: in-memory key/value store for persistence experiments.

## Usage
Add as a path dependency (already configured in the workspace):
```yaml
dependencies:
  shared_repos:
    path: ../../packages/shared_repos
```

In code:
```dart
final stopwatchRepoProvider = Provider<StopwatchRepo>((ref) {
  final repo = StopwatchRepo();
  ref.onDispose(repo.dispose);
  return repo;
});
```

## Development
```bash
cd packages/shared_repos
fvm use 3.35.3
fvm flutter pub get  # not required for pure Dart but keeps toolchain consistent
fvm dart analyze .
```
