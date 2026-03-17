import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_retry_demo/main.dart';
import 'package:shared_repos/shared_repos.dart';

void main() {
  test('retry succeeds after transient failure', () async {
    final logger = RetryLogger();
    final container = ProviderContainer(overrides: [
      retryLoggerProvider.overrideWithValue(logger),
    ]);
    addTearDown(() {
      logger.dispose();
      container.dispose();
    });

    final result = await container.read(userFutureProvider.future);

    expect(result, equals('Riverpod Fan'));
  });

  test('disabling retry raises first error', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(retryToggleProvider.notifier).update(false);

    await expectLater(
      container.read(userFutureProvider.future),
      throwsException,
    );
  });
}
