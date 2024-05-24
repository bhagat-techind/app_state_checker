import 'package:app_state_checker/app_state.dart';

import 'app_state_checker_platform_interface.dart';

class AppStateChecker {
  // Check app state
  Future<AppState> getAppState() {
    return AppStateCheckerPlatform.instance.getAppState();
  }
}
