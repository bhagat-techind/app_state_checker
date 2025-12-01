import 'package:app_state_checker/app_state.dart';
import 'package:app_state_checker/app_state_checker_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MethodChannelAppStateChecker platform = MethodChannelAppStateChecker();
  const MethodChannel channel = MethodChannel('app_state_checker');
  late TestDefaultBinaryMessenger messenger;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

    messenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return AppState.background;
      },
    );
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('getAppState', () async {
    expect(await platform.getAppState(), AppState.background);
  });
}
