import 'package:fluttertoast/fluttertoast.dart';
import 'package:workmanager/workmanager.dart';

const simpleTaskKey = "simpleTask";
const simpleDelayedTask = "simpleDelayedTask";
const simplePeriodicTask = "simplePeriodicTask";
const simplePeriodic1HourTask = "simplePeriodic1HourTask";
const simplePeriodicWithScheduled = "simplePeriodicWithScheduled";

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        print("$simpleTaskKey was executed. inputData = $inputData");
        Fluttertoast.showToast(msg: "Rifa simple task with data");
        break;
      case simpleDelayedTask:
        print("$simpleDelayedTask was executed");
        Fluttertoast.showToast(msg: "Rifa delayed task");
        break;
      case simplePeriodicTask:
        print("$simplePeriodicTask was executed");
        Fluttertoast.showToast(msg: "Rifa periodic task");
        break;
      case simplePeriodic1HourTask:
        print("$simplePeriodic1HourTask was executed");
        Fluttertoast.showToast(msg: "Rifa periodic one hour task");
        break;
      case simplePeriodicWithScheduled:
        print("$simplePeriodicWithScheduled was executed");
        Fluttertoast.showToast(msg: "Rifa periodic with scheduled task");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        Fluttertoast.showToast(msg: "Rifa iOS task");
        break;
    }
    return Future.value(true);
  });
}
