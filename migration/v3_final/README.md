# Riverpod 3.0 Final Style Sample

## Purpose
- Demonstrates Riverpod 3 migration patterns: extracting external repos, using `NotifierProvider`, and leveraging `ref.onDispose`.
- Mirrors `migration/v2_style` to highlight the diff when upgrading from Riverpod 2.x.

## Running
```bash
cd migration/v3_final
fvm use 3.35.3
fvm dart pub get
fvm dart analyze .
```

Used mainly for comparison; this package is not a standalone Flutter application.
