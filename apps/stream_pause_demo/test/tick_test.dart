import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pause_demo/main.dart';

void main() {
  test('tick stream emits sequential integers', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final values = <int>[];
    final sub = container.listen<AsyncValue<int>>(tickStreamProvider, (prev, next) {
      next.whenData(values.add);
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    sub.close();

    expect(values.length, greaterThanOrEqualTo(2));
    expect(values, orderedEquals(List<int>.generate(values.length, (index) => index)));
  });
}
