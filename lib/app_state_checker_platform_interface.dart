import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_state.dart';
import 'app_state_checker_method_channel.dart';

abstract class AppStateCheckerPlatform extends PlatformInterface {
  /// Constructs a AppStateCheckerPlatform.
  AppStateCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppStateCheckerPlatform _instance = MethodChannelAppStateChecker();

  /// The default instance of [AppStateCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppStateChecker].
  static AppStateCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppStateCheckerPlatform] when
  /// they register themselves.
  static set instance(AppStateCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<AppState?> getAppState() {
    throw UnimplementedError('getAppState() has not been implemented.');
  }
}
