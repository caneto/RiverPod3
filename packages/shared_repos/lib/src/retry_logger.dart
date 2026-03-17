import 'dart:async';

class RetryLogEntry {
  RetryLogEntry(this.attempt, this.timestamp);

  final int attempt;
  final DateTime timestamp;
}

class RetryLogger {
  final _events = StreamController<RetryLogEntry>.broadcast();
  int _attempt = 0;

  Stream<RetryLogEntry> get events => _events.stream;

  void recordAttempt() {
    _events.add(RetryLogEntry(++_attempt, DateTime.now()));
  }

  void reset() {
    _attempt = 0;
  }

  void dispose() {
    _events.close();
  }
}
