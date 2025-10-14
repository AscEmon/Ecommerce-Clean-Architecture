 
 import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '/core/di/service_locator.dart';
import '/core/network/network_info.dart';
import 'global_network_dialog.dart';
import '../../routes/navigation.dart';
import '../../utils/extension.dart';
import '../view_util.dart';

class GlobalNetworkListener extends StatefulWidget {
  final Widget child;

  const GlobalNetworkListener({super.key, required this.child});

  @override
  State<GlobalNetworkListener> createState() => _GlobalNetworkListenerState();
}

class _GlobalNetworkListenerState extends State<GlobalNetworkListener> {
  bool _wasConnected = true;
  bool _isShowingDialog = false;
  // Track all active dialog contexts to ensure proper dismissal
  final List<BuildContext> _activeDialogContexts = [];

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
  }

  @override
  void dispose() {
    // Ensure all dialogs are dismissed when widget is disposed
    _dismissAllNetworkDialogs();
    super.dispose();
  }

  Future<void> _checkInitialConnectivity() async {
    final networkInfo = sl<NetworkInfo>();
    _wasConnected = await networkInfo.internetAvailable();

    // Show dialog immediately if no internet on app start
    if (!_wasConnected) {
      _showNetworkErrorDialog();
    }

    // Listen for connectivity changes
    networkInfo.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(List<ConnectivityResult> connectivityResult) {
    final isConnected =
        connectivityResult.isNotEmpty &&
        connectivityResult.any((element) => element != ConnectivityResult.none);

    'isNetworkAvailable :: $isConnected'.log();

    // If network was connected but now disconnected
    if (_wasConnected && !isConnected) {
      _showNetworkErrorDialog();
    }
    // If network was disconnected but now connected
    else if (!_wasConnected && isConnected) {
      _dismissAllNetworkDialogs();
      _retryQueuedRequests();
    }

    _wasConnected = isConnected;
  }

  void _showNetworkErrorDialog() {
    if (_isShowingDialog || !mounted) return;

    _isShowingDialog = true;

    // Show dialog on next frame to avoid build conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Create a dialog context
      final BuildContext dialogContext = Navigation.key.currentContext!;

      ViewUtil.alertDialog(
        barrierDismissible: false,
        content: PopScope(
          canPop: false,
          onPopInvokedWithResult:
              (didpop, result) {}, // Prevent back button from closing dialog
          child: GlobalNetworkDialog(
            onRetry: () async {
              final networkInfo = sl<NetworkInfo>();
              final isConnected = await networkInfo.internetAvailable();

              if (isConnected) {
                _dismissAllNetworkDialogs();
                _retryQueuedRequests();
              }
            },
          ),
        ),
      ).then((_) {
        // Remove this dialog context when it's closed
        _activeDialogContexts.remove(dialogContext);
        if (_activeDialogContexts.isEmpty) {
          _isShowingDialog = false;
        }
      });

      // Add this dialog context to our tracking list
      _activeDialogContexts.add(dialogContext);
    });
  }

  void _dismissAllNetworkDialogs() {
    if (!_isShowingDialog || !mounted) return;

    // Pop all dialogs by repeatedly calling Navigator.pop until no more dialogs
    final navigatorState = Navigation.key.currentState;
    if (navigatorState != null) {
      while (_isShowingDialog && navigatorState.canPop()) {
        navigatorState.pop();
      }
    }

    // Clear the tracking list
    _activeDialogContexts.clear();
    _isShowingDialog = false;
  }

  void _retryQueuedRequests() {
    final networkInfo = sl<NetworkInfo>();

    if (networkInfo is NetworkInfoImpl) {
      if (networkInfo.apiStack.isNotEmpty) {
        for (final request in networkInfo.apiStack) {
          request.execute();
        }
        networkInfo.apiStack.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

 