import 'package:flutter/services.dart';

import 'app_state_checker_platform_interface.dart';

/// An implementation of [AppStateCheckerPlatform] that uses method channels.
class MethodChannelAppStateChecker extends AppStateCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_state_checker');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
