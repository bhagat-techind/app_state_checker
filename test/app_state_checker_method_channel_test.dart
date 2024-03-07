import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_state_checker/app_state_checker_method_channel.dart';

void main() {
  MethodChannelAppStateChecker platform = MethodChannelAppStateChecker();
  const MethodChannel channel = MethodChannel('app_state_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
