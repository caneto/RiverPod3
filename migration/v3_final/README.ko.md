# Riverpod 3.0 Final Style

English version: [`README.md`](README.md).

3.0에서 `Notifier`가 리빌드마다 재생성된다는 점을 고려해 외부 리소스를 Provider로 분리하고 `ref.onDispose`를 활용해 수명 주기를 관리합니다. 또한 필요한 경우 `ref.mounted` 체크와 재시도 전략 커스터마이징으로 비동기 안전성을 보완할 수 있습니다.
