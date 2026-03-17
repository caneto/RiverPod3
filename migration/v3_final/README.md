# Riverpod 3.0 Final Style Sample

Refactored counterpart for the migration walkthrough. 한국어 설명은 [`README.ko.md`](README.ko.md)를 참고하세요.

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
