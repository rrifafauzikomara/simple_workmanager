import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_workmanager/utils/workmanager_helper.dart';
import 'package:workmanager/workmanager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum _Platform { android, ios }

class PlatformEnabledButton extends RaisedButton {
  final _Platform platform;

  PlatformEnabledButton({
    this.platform,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : assert(child != null, onPressed != null),
        super(
            child: child,
            onPressed: (Platform.isAndroid && platform == _Platform.android ||
                    Platform.isIOS && platform == _Platform.ios)
                ? onPressed
                : null);
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter WorkManager Example"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Plugin initialization"),
              RaisedButton(
                  child: Text("Start the Flutter background service"),
                  onPressed: () {
                    Workmanager.initialize(
                      callbackDispatcher,
                      isInDebugMode: false,
                    );
                  }),
              SizedBox(height: 16),
              Text("One Off Tasks (Android only)"),
              //This task runs once.
              //Most likely this will trigger immediately
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register OneOff Task"),
                  onPressed: () {
                    Workmanager.registerOneOffTask(
                      "1",
                      simpleTaskKey,
                      inputData: <String, dynamic>{
                        'int': 1,
                        'bool': true,
                        'double': 1.0,
                        'string': 'string',
                        'array': [1, 2, 3],
                      },
                    );
                  }),
              //This task runs once
              //This wait at least 10 seconds before running
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register Delayed OneOff Task"),
                  onPressed: () {
                    Workmanager.registerOneOffTask(
                      "2",
                      simpleDelayedTask,
                      initialDelay: Duration(seconds: 10),
                    );
                  }),
              SizedBox(height: 8),
              Text("Periodic Tasks (Android only)"),
              //This task runs periodically
              //It will wait at least 10 seconds before its first launch
              //Since we have not provided a frequency it will be the default 15 minutes
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register Periodic Task"),
                  onPressed: () {
                    Workmanager.registerPeriodicTask(
                      "3",
                      simplePeriodicTask,
                      initialDelay: Duration(seconds: 10),
                    );
                  }),
              //This task runs periodically
              //It will run about every hour
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register 1 hour Periodic Task"),
                  onPressed: () {
                    Workmanager.registerPeriodicTask(
                      "4",
                      simplePeriodic1HourTask,
                      frequency: Duration(hours: 1),
                    );
                  }),
              //This task runs periodically
              //It will run about every 9 PM
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register Periodic Task with Scheduled"),
                  onPressed: () {
                    Workmanager.registerPeriodicTask(
                      "5",
                      simplePeriodicWithScheduled,
                      frequency: Duration(hours: 1),
                    );
                  }),
              PlatformEnabledButton(
                platform: _Platform.android,
                child: Text("Cancel All"),
                onPressed: () async {
                  await Workmanager.cancelAll();
                  print('Cancel all tasks completed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
