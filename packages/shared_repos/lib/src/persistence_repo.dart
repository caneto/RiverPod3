import 'dart:async';

class MockPersistenceRepo {
  final Map<String, Object?> _store = <String, Object?>{};
  final _streamController = StreamController<Map<String, Object?>>.broadcast();

  Future<void> write(String key, Object? value) async {
    _store[key] = value;
    _streamController.add(Map<String, Object?>.unmodifiable(_store));
  }

  Future<Object?> read(String key) async => _store[key];

  Stream<Map<String, Object?>> get changes => _streamController.stream;

  void dispose() {
    _streamController.close();
  }
}
