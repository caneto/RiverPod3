# Riverpod 3.0 Demo Workspace

This monorepo hosts the Flutter demos and reference packages that accompany the Riverpod 3.0 blog series. Each directory is its own Dart or Flutter package so you can explore application behavior, shared infrastructure, and migration steps side by side.

## Workspace Layout
- `apps/counter_app`, `network_retry_demo`, `stream_pause_demo`: web-friendly Flutter demos that highlight Riverpod 3.0 behaviors
- `packages/shared_repos`: reusable `StopwatchRepo`, `TickerRepo`, `RetryLogger`, and `MockPersistenceRepo` used across the demos
- `migration/v2_style`, `migration/v3_final`: minimal Dart packages showing the before/after code for a Riverpod 2.x → 3.0 upgrade
- Root tooling: `melos.yaml`, `analysis_options.yaml`, `pubspec.yaml`, `.gitignore`

## Setup
```bash
fvm use 3.35.3
fvm flutter --version        # confirm the toolchain
fvm dart pub global activate melos
melos bootstrap              # wire up path dependencies
```

Run `fvm flutter pub get` (or `fvm dart pub get`) inside individual packages if you need to warm their caches separately.

## Workspace Commands
- `melos run build`: invoke `build_runner` where provider codegen is needed
- `melos run analyze`: run Flutter/Dart analyzers across every package
- `melos run format`: apply `dart format .` from the repo root
- `melos run test`: execute the Flutter unit tests for each demo

## Run a Demo
```bash
cd apps/counter_app
fvm flutter run -d chrome -t lib/main.dart -p 8080
```
Adjust the device ID or port as needed; the other demos follow the same pattern.

## Testing
Use `melos run test` for a suite-wide pass, or run `fvm flutter test` / `fvm dart test` inside individual packages while iterating.

## Next Steps
- Read the README in each app/package for deeper walkthroughs and planned enhancements.
- Explore the `migration/` directory to compare Riverpod 2.x and 3.0 implementations line by line.
