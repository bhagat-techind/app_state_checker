import 'package:app_state_checker/app_state.dart';

import 'app_state_checker_platform_interface.dart';

class AppStateChecker {
  Future<int?> getPlatformVersion() {
    return AppStateCheckerPlatform.instance.getPlatformVersion();
  }

  // Check aap state
  Future<AppState?> getAppState() {
    return AppStateCheckerPlatform.instance.getAppState();
  }
}
