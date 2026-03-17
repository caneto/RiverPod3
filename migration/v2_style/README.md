# Riverpod 2.x Style Sample

## Purpose
- Captures the pre-Riverpod 3 approach using `StateNotifierProvider` and internal resource ownership.
- Serves as the before snapshot when comparing against `migration/v3_final`.

## Running
```bash
cd migration/v2_style
fvm use 3.35.3
fvm dart pub get
fvm dart analyze .
```

This package is not a runnable Flutter app; it exists for side-by-side code comparisons.
