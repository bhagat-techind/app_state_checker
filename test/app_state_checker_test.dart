import 'package:flutter_test/flutter_test.dart';
import 'package:app_state_checker/app_state_checker.dart';
import 'package:app_state_checker/app_state_checker_platform_interface.dart';
import 'package:app_state_checker/app_state_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppStateCheckerPlatform
    with MockPlatformInterfaceMixin
    implements AppStateCheckerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppStateCheckerPlatform initialPlatform =
      AppStateCheckerPlatform.instance;

  test('$MethodChannelAppStateChecker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppStateChecker>());
  });

  test('getPlatformVersion', () async {
    AppStateChecker appStateCheckerPlugin = AppStateChecker();
    MockAppStateCheckerPlatform fakePlatform = MockAppStateCheckerPlatform();
    AppStateCheckerPlatform.instance = fakePlatform;

    expect(await appStateCheckerPlugin.getPlatformVersion(), '42');
  });
}
