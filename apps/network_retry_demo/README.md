# Network Retry Demo (Riverpod 3 Demo)

## Highlights
- Visualizes Riverpod 3's default retry strategy with global and per-provider toggles.
- Streams retry attempts via `RetryLogger` for both UI and testing.
- Simulates transient network failures with `_FlakyUserService`.

## Prerequisites
```bash
cd apps/network_retry_demo
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
- Replace the mock service with a real HTTP client and log `RetryStrategy` overrides per endpoint.
- Surface retry metrics in UI (attempt counts, jitter intervals) using Riverpod `select` to minimize rebuilds.
- Demonstrate provider-scoped overrides for optimistic retry vs. user-triggered retry flows.
- Add golden tests or integration tests capturing the retry snackbar/loading experience.

## Related Docs
- Blog section: *자동 재시도와 오류 UX 개선*
- Shared utilities: `packages/shared_repos`
