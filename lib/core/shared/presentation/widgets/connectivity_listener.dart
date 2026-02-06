import 'package:flutter/material.dart';
import 'package:pokeapp/core/network/connectivity_watcher/connectivity_checker.dart';
import 'package:pokeapp/core/network/connectivity_watcher/connectivity_watcher.dart';
import 'package:pokeapp/core/network/connectivity_watcher/connectivity_watcher_impl.dart';

class ConnectivityListener extends StatefulWidget {
  const ConnectivityListener({
    super.key,
    required this.child,
    required this.onConnectivityChanged,
  });

  final Widget child;
  final ValueChanged<bool> onConnectivityChanged;

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  late ConnectivityWatcher _connectivityWatcher;

  @override
  void initState() {
    super.initState();
    _connectivityWatcher = ConnectivityWatcherImpl(ConnectivityChecker(), (
      bool isConnected,
    ) {
      if (mounted) {
        widget.onConnectivityChanged(isConnected);
      }
    });
    _connectivityWatcher.startMonitoring();
  }

  @override
  void dispose() {
    _connectivityWatcher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
