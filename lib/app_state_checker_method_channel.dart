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
  Future<int?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<int>('getPlatformVersion');
    return version;
  }

  @override
  Future<AppState?> getAppState() async {
    final version = await methodChannel.invokeMethod<AppState>('getAppState');
    return version;
  }
}
