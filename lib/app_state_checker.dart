import 'app_state_checker_platform_interface.dart';

class AppStateChecker {
  Future<String?> getPlatformVersion() {
    return AppStateCheckerPlatform.instance.getPlatformVersion();
  }
}
