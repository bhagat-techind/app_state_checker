# app_state_checker

A new Flutter plugin to check current state of your app, whether app is in running state, background state or kill state 
By using this plugin you can check whether your app in in active state, [AppState](lib/app_state.dart) and can handle your use case on behalf of this.


## Installing

command:

```dart
 $ flutter pub add app_state_checker
```

pubspec.yaml:

## Usage

We are using following methods :-

- getAppState() : To get app current state.
- [AppState](lib/app_state.dart) : See all states percent in this plugin.

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
  AppState _appState = AppState.unknown;

  final _appStateCheckerPlugin = AppStateChecker();

  @override
  void initState() {
    super.initState();
    getAppState();
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
          title: const Text('App state'),
        ),
        body: Center(
          child:Text('App State: $_appState\n'),
        ),
      ),
    );
  }
}
```