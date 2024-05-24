import 'package:app_state_checker/app_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_state_checker/app_state_checker_method_channel.dart';

void main() {
  MethodChannelAppStateChecker platform = MethodChannelAppStateChecker();
  const MethodChannel channel = MethodChannel('app_state_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return AppState.background;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getAppState', () async {
    expect(await platform.getAppState(), AppState.background);
  });
}
