# Riverpod 2.x Style

English version: [`README.md`](README.md).

이 패키지는 기존 `StateNotifierProvider` 기반 상태 관리를 유지한 채 Riverpod 3로 이전하기 전의 구조를 재현합니다.
- 내부 리소스를 직접 Notifier에서 생성/보관합니다.
- 재시도 전략이나 `ref.mounted`와 같은 3.0 API는 사용하지 않습니다.
