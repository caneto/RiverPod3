# Counter App (Riverpod 3 Demo)


## Highlights
- Demonstrates how Riverpod 3's `Notifier` instances are recreated on rebuilds.
- Consumes shared repos (`StopwatchRepo`, `MockPersistenceRepo`) via providers to manage lifecycles.
- Includes a persistence button that triggers the experimental persistence stream.

## Prerequisites
```bash
cd apps/counter_app
fvm use 3.35.3
fvm flutter pub get
```

## Run
```bash
fvm flutter run -d chrome
```

## Test
```bash
fvm flutter test
```

## Planned Enhancements
- Swap in `AsyncNotifier` examples that fetch remote state and showcase `ref.mounted` usage.
- Wire a real persistence layer (e.g., `shared_preferences`) alongside the mock repo for side-by-side comparison.
- Add generated providers via `riverpod_generator` to contrast manual vs. codegen flows.
- Visualize rebuild counts and stopwatch deltas to quantify the lifecycle changes in Riverpod 3.

## Related Docs
- Blog section: *Notifier 재생성과 리소스 외부화*
- Todo checklist: `TODO.md`
