import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'app_state.dart';
import 'app_state_checker_platform_interface.dart';

/// An implementation of [AppStateCheckerPlatform] that uses method channels.
class MethodChannelAppStateChecker extends AppStateCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_state_checker');

  @override
  Future<AppState> getAppState() async {
    final stateInt = await methodChannel.invokeMethod<int>('getAppState');
    switch (stateInt) {
      case 0:
        return AppState.foreground;
      case 1:
        return AppState.background;
      case 2:
        return AppState.killState;
      default:
        return AppState.unknown;
    }
  }
}
