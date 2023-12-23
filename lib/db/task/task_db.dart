import 'dart:async';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/MODEL/shaduleTask_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const ADDTASK_DB_NAME = 'tasks';

abstract class AddTaskDbFunction {
  Future<void> insertTask(ShaduleTaskModel value);
  Future<List<ShaduleTaskModel>> getTask();
  Future<List<dynamic>> getLast2data();
  Future<dynamic> getAlldatafom2table();
  Future<List<dynamic>> pendingTasklist();
  Future<void> deleteTask(id);
  Future<List<ShaduleTaskModel>> pendingTask();
  Future<List<ShaduleTaskModel>> completed();
  Future<void> updateItemTask(ShaduleTaskModel updateValue);
  Future<void> scheduleNotificationsFromHive();
}

class AddTaskDB implements AddTaskDbFunction {
  @override
  Future<void> insertTask(ShaduleTaskModel value) async {
    final taskDB = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    await taskDB.put(value.id, value);
    print('new task ${value}');
  }

  @override
  Future<List<ShaduleTaskModel>> getTask() async {
    final taskDb = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    return taskDb.values.toList();
  }

  // last2data from task
  @override
  Future<List<dynamic>> getLast2data() async {
    final boxA = await Hive.openBox<AddPlantModel>('plant');
    final boxB = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    final boxc = await Hive.openBox<CreateRoomModel>('room');

    final List<AddPlantModel> itemsFromBoxA = await boxA.values.toList();
    final List<ShaduleTaskModel> itemsFromBoxB = await boxB.values.toList();
    final List<CreateRoomModel> itemsFromBoxc = await boxc.values.toList();

    // Combine the data based on the common field
    final List<dynamic> combinedData = [];
    List<dynamic> last2data = [];
    for (final boxcItem in itemsFromBoxc) {
      for (final boxAItem in itemsFromBoxA) {
        print(2222222222222222);
        for (final boxBItem in itemsFromBoxB) {
          if (boxBItem.plantid == boxAItem.id &&
              boxBItem.roomid == boxcItem.id) {
            print('111111111111111111111111');
            // Combine the data as needed
            final Map<String, dynamic> combinedItem = {
              'plantimg': boxAItem.imagePath,
              'plantname': boxAItem.plantname,
              'dateandtime': boxBItem.dateTime,
              'plantid': boxBItem.plantid,
              'roomid': boxBItem.roomid,
              'id': boxBItem.id,
              'taskname': boxBItem.taskname,
              'roomname': boxcItem.name,
              'taskcomplete': boxBItem.taskcomplete,
            };
            combinedData.add(combinedItem);
          }
        }
      }
    }

    if (combinedData.length == 1) {
      last2data = combinedData.toList().sublist((combinedData.isNotEmpty)
          ? combinedData.length - 1
          : combinedData.length);
    } else {
      last2data = combinedData.toList().sublist((combinedData.isNotEmpty)
          ? combinedData.length - 2
          : combinedData.length);
    }
    print(last2data);
    return last2data;
  }

  @override
  Future<List<dynamic>> getAlldatafom2table() async {
    final boxA = await Hive.openBox<AddPlantModel>('plant');
    final boxB = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    final boxc = await Hive.openBox<CreateRoomModel>('room');

    final List<AddPlantModel> itemsFromBoxA = await boxA.values.toList();
    final List<ShaduleTaskModel> itemsFromBoxB = await boxB.values.toList();
    final List<CreateRoomModel> itemsFromBoxc = await boxc.values.toList();

    // Combine the data based on the common field
    final List<dynamic> combinedData = [];

    for (final boxcItem in itemsFromBoxc) {
      for (final boxAItem in itemsFromBoxA) {
        print(2222222222222222);
        for (final boxBItem in itemsFromBoxB) {
          if (boxBItem.plantid == boxAItem.id &&
              boxBItem.roomid == boxcItem.id) {
            print('111111111111111111111111');
            // Combine the data as needed
            final Map<String, dynamic> combinedItem = {
              'plantimg': boxAItem.imagePath,
              'plantname': boxAItem.plantname,
              'dateandtime': boxBItem.dateTime,
              'plantid': boxBItem.plantid,
              'roomid': boxBItem.roomid,
              'id': boxBItem.id,
              'taskname': boxBItem.taskname,
              'roomname': boxcItem.name,
              'taskcomplete': boxBItem.taskcomplete,
            };
            combinedData.add(combinedItem);
          }
        }
      }
    }
    return combinedData;
  }

  @override
  Future<List<dynamic>> pendingTasklist() async {
    final boxA = await Hive.openBox<AddPlantModel>('plant');
    final boxB = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    final boxc = await Hive.openBox<CreateRoomModel>('room');

    final List<AddPlantModel> itemsFromBoxA = await boxA.values.toList();
    final List<ShaduleTaskModel> itemsFromBoxB = await boxB.values.toList();
    final List<CreateRoomModel> itemsFromBoxc = await boxc.values.toList();

    // Combine the data based on the common field
    final List<dynamic> combinedData = [];

    for (final boxcItem in itemsFromBoxc) {
      for (final boxAItem in itemsFromBoxA) {
        print(2222222222222222);
        for (final boxBItem in itemsFromBoxB) {
          if (boxBItem.plantid == boxAItem.id &&
              boxBItem.roomid == boxcItem.id &&
              boxBItem.taskcomplete == 1) {
            print('111111111111111111111111');
            // Combine the data as needed
            final Map<String, dynamic> combinedItem = {
              'plantimg': boxAItem.imagePath,
              'plantname': boxAItem.plantname,
              'dateandtime': boxBItem.dateTime,
              'plantid': boxBItem.plantid,
              'roomid': boxBItem.roomid,
              'id': boxBItem.id,
              'taskname': boxBItem.taskname,
              'roomname': boxcItem.name,
              'taskcomplete': boxBItem.taskcomplete,
            };
            combinedData.add(combinedItem);
          }
        }
      }
    }
    return combinedData;
  }

  @override
  Future<List<ShaduleTaskModel>> pendingTask() async {
    final taskDb = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    final pendingTask =
        taskDb.values.where((element) => element.taskcomplete == 1).toList();
    return pendingTask;
  }

  @override
  Future<List<ShaduleTaskModel>> completed() async {
    final taskDb = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    final pendingTask =
        taskDb.values.where((element) => element.taskcomplete == 2).toList();
    return pendingTask;
  }

  @override
  Future<void> updateItemTask(ShaduleTaskModel updateValue) async {
    final updTaskDb = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    await updTaskDb.put(updateValue.id, updateValue);
    print('update $updateValue');
  }

  @override
  Future<void> deleteTask(id) async {
    print(id);
    final taskDb = await Hive.openBox<ShaduleTaskModel>(ADDTASK_DB_NAME);
    await taskDb.delete(id);
  }

  @override
  Future<void> scheduleNotificationsFromHive() async {
    tz.initializeTimeZones();

    // Get your Hive box for the data
    Box<ShaduleTaskModel> myDataBox =
        Hive.box<ShaduleTaskModel>(ADDTASK_DB_NAME);

    // Loop through the data in Hive
    for (int i = 0; i < myDataBox.length; i++) {
      ShaduleTaskModel? data = myDataBox.getAt(i);

      // Check if data has a valid DateTime
      if (data != null && data.dateTime != null) {
        // Convert the stored date and time to the local time zone
        tz.TZDateTime scheduledTime =
            tz.TZDateTime.from(data.dateTime, tz.local);

        // Check if the scheduled time is in the future
        if (scheduledTime.isAfter(DateTime.now())) {
          scheduleNotification(data.taskname, data.taskname, scheduledTime);
        }
      }
    }
  }

  void scheduleNotification(
      String plantName, String taskName, tz.TZDateTime time) {
    const fln.AndroidNotificationDetails androidNotificationDetails =
        fln.AndroidNotificationDetails(
      "ScheduleNotification001",
      "notify_me",
      importance: fln.Importance.max,
      priority: fln.Priority.max,
      playSound: true,
      enableVibration: true,
    );

    const fln.NotificationDetails notificationDetails = fln.NotificationDetails(
      android: androidNotificationDetails,
      iOS: null,
      macOS: null,
      linux: null,
    );

    fln.FlutterLocalNotificationsPlugin().zonedSchedule(
      01,
      plantName,
      taskName,
      time,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          fln.UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: fln.DateTimeComponents.dateAndTime,
      androidAllowWhileIdle: true,
      payload: "aaaaaaaaaaa",
    );
  }
}
