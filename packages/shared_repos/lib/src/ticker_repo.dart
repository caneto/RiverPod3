import 'dart:async';

class TickerRepo {
  Stream<int> tick({Duration interval = const Duration(milliseconds: 300)}) async* {
    var current = 0;
    while (true) {
      await Future.delayed(interval);
      yield current++;
    }
  }
}
