import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokeapp/core/network/connectivity_watcher/connectivity_checker.dart';
import 'package:pokeapp/core/network/connectivity_watcher/connectivity_watcher.dart';

class ConnectivityWatcherImpl implements ConnectivityWatcher {
  ConnectivityWatcherImpl(
    this._connectivityChecker,
    this._onConnectivityChanged,
  );

  Timer? _timer;
  bool? _lastStatus;
  final ConnectivityChecker _connectivityChecker;
  final ValueChanged<bool> _onConnectivityChanged;

  @override
  void startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      var currentStatus = _lastStatus ?? false;
      try {
        currentStatus = await _connectivityChecker.hasRealInternetAccess();
      } catch (_) {
        currentStatus = false;
      }

      if (_lastStatus != currentStatus) {
        _lastStatus = currentStatus;
        _onConnectivityChanged(currentStatus);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
  }
}
