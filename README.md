# app_state_checker

A new Flutter plugin to check app state, like background foreground.

## Installing

command:

```dart
 $ flutter pub add app_state_checker
```

pubspec.yaml:

## Usage

We are using following methods :-

- getAppState() \* => To get aap state use this method.
- AppState \* => All state percent in this enum.

## Full Example

```dart
import 'dart:async';
import 'package:app_state_checker/app_state.dart';
import 'package:app_state_checker/app_state_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _platformVersion = -1;
  AppState _appState = AppState.unknown;

  final _appStateCheckerPlugin = AppStateChecker();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getAppState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    int platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _appStateCheckerPlugin.getPlatformVersion() ?? -1;
    } on PlatformException {
      platformVersion = -1;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getAppState() async {
    AppState appState;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      appState = await _appStateCheckerPlugin.getAppState() ?? AppState.unknown;
    } on PlatformException {
      appState = AppState.unknown;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appState = appState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('App State: $_appState\n'),
            ],
          ),
        ),
      ),
    );
  }
}
```