# Stream Pause Demo (Riverpod 3 Demo)

## Highlights
- Toggles listening to a ticker stream to demonstrate Riverpod 3's auto pause behavior.
- Uses `TickerRepo` from `shared_repos` to emit lightweight ticks.
- UI mirrors `AsyncValue` states so the pause transition is visible.

## Prerequisites
```bash
cd apps/stream_pause_demo
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
- Pair the pause demo with CPU/memory metrics and a chart to visualize savings when listeners detach.
- Add `selectAsync` examples that combine the ticker with derived state to highlight rebuild granularity.
- Introduce a secondary screen demonstrating queued background work while streams are paused.
- Write integration tests that toggle tabs and assert listener counts via `ProviderObserver` hooks.

## Related Docs
- Blog section: *StreamProvider pause로 낭비 줄이기*
- Todo checklist: `TODO.md`
