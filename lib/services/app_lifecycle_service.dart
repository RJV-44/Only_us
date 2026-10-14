import 'dart:async';

import 'package:flutter/widgets.dart';

class AppLifecycleService with WidgetsBindingObserver {
  AppLifecycleService();

  final _states = StreamController<AppLifecycleState>.broadcast();
  bool _isStarted = false;

  Stream<AppLifecycleState> get states => _states.stream;

  void start() {
    if (_isStarted) return;
    WidgetsBinding.instance.addObserver(this);
    _isStarted = true;
    final state = WidgetsBinding.instance.lifecycleState;
    if (state != null) _states.add(state);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_states.isClosed) _states.add(state);
  }

  Future<void> dispose() async {
    if (_isStarted) {
      WidgetsBinding.instance.removeObserver(this);
      _isStarted = false;
    }
    await _states.close();
  }
}
