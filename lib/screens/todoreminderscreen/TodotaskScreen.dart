import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/db/room/room_db.dart';
import 'package:greeni_care/screens/todoreminderscreen/pendingTasks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/shaduleTask_model.dart';
import 'package:greeni_care/db/addplant/addplant_db.dart';
import 'package:greeni_care/db/task/task_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:lottie/lottie.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// import 'package:timezone/timezone.dart' as tz;

class TodotaskScreen extends StatefulWidget {
  const TodotaskScreen({Key? key}) : super(key: key);

  @override
  _TodotaskScreenState createState() => _TodotaskScreenState();
}

class _TodotaskScreenState extends State<TodotaskScreen> {
  late Box<AddPlantModel> plantsBox = Hive.box<AddPlantModel>('plant');
  late List<AddPlantModel> plantList = [];
  late List<CreateRoomModel> roomList = [];
  late List<dynamic> alllistplantandtask = [];
  late List<ShaduleTaskModel> pendingTask = [];
  late List<ShaduleTaskModel> completed = [];
  final _errormessage = 'DELETE PLANT SUCESS';

  late TextEditingController _plantname;
  late TextEditingController _taskname = TextEditingController();

  //date nd time select
  late TextEditingController _date = TextEditingController();
  late TextEditingController _time = TextEditingController();

  //current date and time
  DateTime dateTime = DateTime.now();
  //for form
  final _formkey = GlobalKey<FormState>();

  //localnotification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //take the room id from when select drop down value and store to this variable
  int? _plantid;
  int? _roomiddrop;
  @override
  void initState() {
    pendingTask;
    completed;
    AddTaskDB().getAlldatafom2table().then(
      (value) {
        print('all data frm 2 table : ${value}');
        setState(() {
          alllistplantandtask = value.toList();
        });
      },
    );
    AddPlantDB().getPlant().then(
      (value) {
        print(value);
        setState(() {
          plantList = value.toList();
        });
      },
    );
    RoomDb().getRoom().then((value) {
      print('room in task list :${value}');
      setState(() {
        roomList = value.toList();
      });
    });
    AddTaskDB().pendingTask().then(
      (value) {
        setState(() {
          print('pending task : ${pendingTask}');
          pendingTask = value.toList();
        });
      },
    );
    AddTaskDB().completed().then(
      (value) {
        setState(() {
          print('pending task : ${pendingTask}');
          completed = value.toList();
        });
      },
    );

    _plantname = TextEditingController();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/launcher_icon");
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: null,
      macOS: null,
      linux: null,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    // TODO: implement initState
    super.initState();
  }

  showNotification() {
    if (_plantid == null || _taskname.text.isEmpty) {
      return;
    }
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "SheduleNotification001",
      "notifi me",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: null,
      macOS: null,
      linux: null,
    );

    // flutterLocalNotificationsPlugin.show(
    //     01, _plantname.text, _taskname.text, notificationDetails);

    tz.initializeTimeZones();
    final tz.TZDateTime sheduleAt = tz.TZDateTime.from(dateTime, tz.local);
    print('shaduled at time zone :${sheduleAt}');

    flutterLocalNotificationsPlugin.zonedSchedule(
      01,
      _plantname.text,
      _taskname.text,
      sheduleAt,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      androidAllowWhileIdle: true,
      payload: "aaaaaaaaaaa",
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    // color: Colors.amber,
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //back button
                    InkWell(
                      onTap: () {
                        //newIndex is in this page is predefined
                        int newIndex = 0;
                        RoutsManager.selectedIndexNotifier.value = newIndex;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return RoutsManager();
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset('asset/images/ArrowBack.png'),
                          const Text(
                            'Back',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //add palnt text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SCHEDULE TASK',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return PendingTasks();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'PENDING: (${pendingTask.length})',
                            style: TextStyle(
                              color: Color.fromARGB(226, 121, 129, 89),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ALL TASK LIST'),
                        Text('Completed: (${completed.length})',
                            style: TextStyle(
                                color: Color.fromARGB(255, 116, 4, 150))),
                        TextButton(
                          onPressed: () {
                            setState(
                              () {
                                showDialog(
                                  context: context,
                                  builder: (ctx1) {
                                    return Form(
                                      key: _formkey,
                                      child: Container(
                                        width: 20,
                                        height: 30,
                                        color: Color.fromARGB(38, 41, 37, 25),
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(),
                                          backgroundColor: Color.fromRGBO(
                                              164, 189, 20, 0.466),
                                          content: SingleChildScrollView(
                                            child: Container(
                                              width:
                                                  300.0, // Set the width of the AlertDialog
                                              height:
                                                  500.0, // Set the height of the AlertDialog
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10.0),

                                                  ///room dropdown
                                                  StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      right:
                                                                          16),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    104,
                                                                    255,
                                                                    255,
                                                                    255),
                                                              ),
                                                              child:
                                                                  DropdownButton(
                                                                hint: (roomList
                                                                        .isEmpty)
                                                                    ? Text(
                                                                        'CREATE ROOM FIRST')
                                                                    : Center(
                                                                        child: Text(
                                                                            'SELECT Room'),
                                                                      ),
                                                                focusColor:
                                                                    Colors
                                                                        .amber,
                                                                dropdownColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            169,
                                                                            182,
                                                                            99),
                                                                elevation: 5,
                                                                icon: Icon(Icons
                                                                    .arrow_drop_down),
                                                                iconSize: 30,
                                                                isExpanded:
                                                                    true,
                                                                value:
                                                                    _roomiddrop,
                                                                items: roomList
                                                                    .map((e) {
                                                                  return DropdownMenuItem(
                                                                    value: e.id,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(e
                                                                            .name),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                                onChanged:
                                                                    (selectedvalue) {
                                                                  setState(() {
                                                                    _roomiddrop =
                                                                        selectedvalue;
                                                                    _plantid =
                                                                        null;
                                                                    print(
                                                                        _roomiddrop);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 16,
                                                                      right:
                                                                          16),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    104,
                                                                    255,
                                                                    255,
                                                                    255),
                                                              ),
                                                              child:
                                                                  DropdownButton(
                                                                hint: (plantList
                                                                        .isEmpty)
                                                                    ? Text(
                                                                        'PLANT IS EMPTY ADD PLANT')
                                                                    : Center(
                                                                        child: Text(
                                                                            'SELECT PlANT'),
                                                                      ),
                                                                focusColor:
                                                                    Colors
                                                                        .amber,
                                                                dropdownColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            169,
                                                                            182,
                                                                            99),
                                                                elevation: 5,
                                                                icon: Icon(Icons
                                                                    .arrow_drop_down),
                                                                iconSize: 30,
                                                                isExpanded:
                                                                    true,
                                                                value: _plantid,
                                                                onChanged:
                                                                    (selectedvalues) {
                                                                  setState(() {
                                                                    _plantid =
                                                                        selectedvalues
                                                                            as int?;
                                                                    print(
                                                                        _plantid);
                                                                  });
                                                                },
                                                                items: (_roomiddrop !=
                                                                        null)
                                                                    ? plantList
                                                                        .where((plant) =>
                                                                            plant.roomid ==
                                                                            _roomiddrop)
                                                                        .toList()
                                                                        .map(
                                                                            (plant) {
                                                                        return DropdownMenuItem<
                                                                            int>(
                                                                          value:
                                                                              plant.id,
                                                                          child:
                                                                              Text(plant.plantname),
                                                                        );
                                                                      }).toList()
                                                                    : [],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: TextFormField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller: _taskname,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(15),
                                                        isCollapsed: true,
                                                        isDense: true,
                                                        hintText: 'TASK NAME',
                                                        fillColor: const Color
                                                            .fromARGB(
                                                            104, 255, 255, 255),
                                                        filled: true,
                                                        border: OutlineInputBorder(
                                                            // borderRadius:
                                                            //     BorderRadius.circular(
                                                            //         30),
                                                            ),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'please enter ROOM name';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final DateTime?
                                                            selectedDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate: dateTime,
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime.now()
                                                                  .add(Duration(
                                                                      days: 30 *
                                                                          365)),
                                                        );
                                                        if (selectedDate ==
                                                            null) {
                                                          return;
                                                        } else {
                                                          print(selectedDate);
                                                        }
                                                        setState(() {
                                                          dateTime =
                                                              selectedDate;
                                                          _date.text =
                                                              "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                                                        });
                                                      },
                                                      child: TextFormField(
                                                        enabled: false,
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller: _date,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          isCollapsed: true,
                                                          isDense: true,
                                                          hintText:
                                                              'SELECT DATE',
                                                          fillColor: const Color
                                                              .fromARGB(104,
                                                              255, 255, 255),
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                              // borderRadius:
                                                              //     BorderRadius.circular(
                                                              //         30),
                                                              ),
                                                          suffixIcon: InkWell(
                                                            onTap: () async {
                                                              final DateTime?
                                                                  selectedDate =
                                                                  await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    dateTime,
                                                                firstDate:
                                                                    DateTime
                                                                        .now(),
                                                                lastDate: DateTime
                                                                        .now()
                                                                    .add(Duration(
                                                                        days: 30 *
                                                                            365)),
                                                              );
                                                              if (selectedDate ==
                                                                  null) {
                                                                return;
                                                              } else {
                                                                print(
                                                                    selectedDate);
                                                              }
                                                              setState(() {
                                                                dateTime =
                                                                    selectedDate;
                                                                _date.text =
                                                                    "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.date_range,
                                                            ),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'please enter ROOM name';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 30.0),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final TimeOfDay?
                                                            selectTime =
                                                            await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    TimeOfDay
                                                                        .now());
                                                        if (selectTime ==
                                                            null) {
                                                          return;
                                                        } else {
                                                          print(selectTime);
                                                        }
                                                        _time.text =
                                                            "${selectTime.hour}/${selectTime.minute}/${selectTime.period.toString()}";

                                                        DateTime newDT =
                                                            DateTime(
                                                                dateTime.year,
                                                                dateTime.month,
                                                                dateTime.day,
                                                                selectTime.hour,
                                                                selectTime
                                                                    .minute);

                                                        setState(() {
                                                          dateTime = newDT;
                                                          print(dateTime);
                                                        });
                                                      },
                                                      child: TextFormField(
                                                        enabled: false,
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller: _time,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          isCollapsed: true,
                                                          isDense: true,
                                                          hintText:
                                                              'SELECT TIME',
                                                          fillColor: const Color
                                                              .fromARGB(104,
                                                              255, 255, 255),
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                              // borderRadius:
                                                              //     BorderRadius.circular(
                                                              //         30),
                                                              ),
                                                          suffixIcon: InkWell(
                                                            onTap: () async {
                                                              final TimeOfDay?
                                                                  selectTime =
                                                                  await showTimePicker(
                                                                      context:
                                                                          context,
                                                                      initialTime:
                                                                          TimeOfDay
                                                                              .now());
                                                              if (selectTime ==
                                                                  null) {
                                                                return;
                                                              } else {
                                                                print(
                                                                    selectTime);
                                                              }
                                                              _time.text =
                                                                  "${selectTime.hour}/${selectTime.minute}/${selectTime.period.toString()}";

                                                              DateTime newDT =
                                                                  DateTime(
                                                                      dateTime
                                                                          .year,
                                                                      dateTime
                                                                          .month,
                                                                      dateTime
                                                                          .day,
                                                                      selectTime
                                                                          .hour,
                                                                      selectTime
                                                                          .minute);

                                                              setState(() {
                                                                dateTime =
                                                                    newDT;
                                                                print(dateTime);
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .timer_outlined,
                                                            ),
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'please enter ROOM name';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 30.0),
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (_formkey
                                                                .currentState!
                                                                .validate()) {
                                                              setState(() {
                                                                // showNotification();
                                                                AddTaskDB()
                                                                    .scheduleNotificationsFromHive();
                                                                saveTask(
                                                                    context);
                                                                // Navigator.pop(
                                                                //     context);
                                                              });

                                                              // addAccount(context);
                                                            } else {
                                                              print(
                                                                  'data empty');
                                                            }
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 105,
                                                            height: 41,
                                                            color: const Color
                                                                .fromARGB(115,
                                                                244, 67, 54),
                                                            child: Text(
                                                              'SAVE',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 105,
                                                            height: 41,
                                                            color:
                                                                Color.fromARGB(
                                                                    87,
                                                                    23,
                                                                    95,
                                                                    20),
                                                            child: Text(
                                                              'BACK',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            'ADD TASK',
                            style: TextStyle(
                              color: Color.fromARGB(226, 121, 129, 89),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            ///
            (alllistplantandtask.isNotEmpty)
                ? Container(
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: alllistplantandtask.length,
                      itemBuilder: (ctx, index) {
                        final _value = alllistplantandtask[index]['id'];
                        return Slidable(
                          key: Key(_value.toString()),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (ctx) {
                                  print('delete task');
                                  setState(
                                    () {
                                      AddTaskDB().deleteTask(_value);
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (ctx) {
                                        return RoutsManager();
                                      }), (route) => false);
                                      final valueName =
                                          alllistplantandtask[index]
                                              ['taskname'];
                                      showSnakebar(context, valueName);
                                    },
                                  );
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                                padding: EdgeInsets.all(
                                    8.0), // Adjust padding as needed
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat.jm().format(
                                        alllistplantandtask[index]
                                            ["dateandtime"]),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 228, 19, 19),
                                      // fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('d,MM,yyyy').format(
                                        alllistplantandtask[index]
                                            ["dateandtime"]),
                                    style: TextStyle(
                                      // fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 15),
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                  alllistplantandtask[index]
                                                      ['plantimg'])),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          // color: Colors.amber,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${alllistplantandtask[index]['taskname']} ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${alllistplantandtask[index]['plantname']} ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    ': (${alllistplantandtask[index]['roomname']})',
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      (alllistplantandtask[index]
                                                  ['taskcomplete'] ==
                                              2)
                                          ? Expanded(
                                              child: Container(
                                                // color: Colors.black,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      print('task complete');
                                                      final updateTaskid =
                                                          alllistplantandtask[
                                                              index]['id'];
                                                      final updatePlantid =
                                                          alllistplantandtask[
                                                              index]['plantid'];
                                                      final updateRoomid =
                                                          alllistplantandtask[
                                                              index]['roomid'];
                                                      final updateTaskname =
                                                          alllistplantandtask[
                                                                  index]
                                                              ['taskname'];
                                                      final updateDatetime =
                                                          alllistplantandtask[
                                                                  index]
                                                              ['dateandtime'];
                                                      final updateCompleteTask =
                                                          alllistplantandtask[
                                                                  index]
                                                              ['taskcomplete'];
                                                      updateTaskcomplete(
                                                          context,
                                                          updateTaskid,
                                                          updatePlantid,
                                                          updateRoomid,
                                                          updateTaskname,
                                                          updateDatetime,
                                                          updateCompleteTask);
                                                    });
                                                  },
                                                  icon: Image.asset(
                                                    'asset/images/todaytasktickfill.png',
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              child: Container(
                                                // color: Colors.black,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      print('task complete');
                                                      final updateTaskid =
                                                          alllistplantandtask[
                                                              index]['id'];
                                                      final updatePlantid =
                                                          alllistplantandtask[
                                                              index]['plantid'];
                                                      final updateRoomid =
                                                          alllistplantandtask[
                                                              index]['roomid'];
                                                      final updateTaskname =
                                                          alllistplantandtask[
                                                                  index]
                                                              ['taskname'];
                                                      final updateDatetime =
                                                          alllistplantandtask[
                                                                  index]
                                                              ['dateandtime'];
                                                      final updateCompleteTask =
                                                          alllistplantandtask[
                                                                  index]
                                                              ['taskcomplete'];
                                                      updateTaskcomplete(
                                                          context,
                                                          updateTaskid,
                                                          updatePlantid,
                                                          updateRoomid,
                                                          updateTaskname,
                                                          updateDatetime,
                                                          updateCompleteTask);
                                                      showSnakebarcomplete(
                                                          context,
                                                          updateTaskname);
                                                    });
                                                  },
                                                  icon: Image.asset(
                                                    'asset/images/todaytaskticknotfill.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Container(
                      child: Column(
                        children: [
                          Lottie.asset('asset/animations/emptytask.json'),
                          Text('task is empty'),
                        ],
                      ),
                    ),
                  ),

            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  void showSnakebar(BuildContext context, valueName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: Color.fromARGB(244, 255, 255, 255),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(40),
        content: Column(
          children: [
            Lottie.asset('asset/animations/delete.json'),
            Text(
              'TASK DELETED : [${valueName}]',
              style: TextStyle(
                  color: Color.fromARGB(255, 128, 23, 23),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void showSnakebarcomplete(BuildContext context, updateTaskname) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: Color.fromARGB(244, 255, 255, 255),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(40),
        content: Column(
          children: [
            Lottie.asset('asset/animations/taskcomplete.json'),
            Text(
              'TASK COMPLETE : [ ${updateTaskname} ]',
              style: TextStyle(
                  color: const Color.fromARGB(255, 23, 128, 26),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateTaskcomplete(context, updateTaskid, updatePlantid,
      updateRoomid, updateTaskname, updateDatetime, updateCompleteTask) async {
    print('updateid : (${updateTaskid})');
    print('updateplantid : (${updatePlantid})');
    print('updateRoomid : (${updateRoomid})');
    print('updateRoomid : (${updateTaskname})');
    print('updateTaskName: (${updateDatetime})');
    print('updateTaskName: (${updateCompleteTask})');
    if (updateCompleteTask == 1) {
      int upTaskid = updateTaskid;
      int uproomidsave = updateRoomid;
      int upplantidsave = updatePlantid;
      final uptasknamesave = updateTaskname;
      DateTime updateimesave = updateDatetime;
      final uptaskcompletevalue = 2;

      final updateTask = ShaduleTaskModel(
        id: upTaskid,
        roomid: uproomidsave,
        plantid: upplantidsave,
        taskname: uptasknamesave,
        dateTime: updateimesave,
        taskcomplete: uptaskcompletevalue,
      );

      AddTaskDB().updateItemTask(updateTask);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx1) {
        return RoutsManager();
      }), (route) => false);
    } else {
      int upTaskid = updateTaskid;
      int uproomidsave = updateRoomid;
      int upplantidsave = updatePlantid;
      final uptasknamesave = updateTaskname;
      DateTime updateimesave = updateDatetime;
      final uptaskcompletevalue = 1;

      final updateTask = ShaduleTaskModel(
        id: upTaskid,
        roomid: uproomidsave,
        plantid: upplantidsave,
        taskname: uptasknamesave,
        dateTime: updateimesave,
        taskcomplete: uptaskcompletevalue,
      );

      AddTaskDB().updateItemTask(updateTask);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (ctx1) {
          return RoutsManager();
        },
      ), (route) => false);
    }
  }

  Future<void> saveTask(BuildContext context) async {
    int? roomidsave = _roomiddrop;
    int? plantidsave = _plantid;
    final tasknamesave = _taskname.text;
    DateTime dateimesave = dateTime;
    final taskcompletevalue = 1;

    print('room id ${roomidsave}');
    print('plant id ${plantidsave}');
    print('task name ${tasknamesave}');
    print('date and time ${dateimesave}');

    AddTaskDB().getTask().then((value) {
      final iu1 = value.toList();
      final id = iu1.isEmpty ? 1 : iu1.last.id! + 1;
      final addTasks = ShaduleTaskModel(
        id: id,
        roomid: roomidsave!,
        plantid: plantidsave!,
        taskname: tasknamesave,
        dateTime: dateimesave,
        taskcomplete: taskcompletevalue,
      );
      AddTaskDB().insertTask(addTasks);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx1) {
        return RoutsManager();
      }), (route) => false);
    });
  }
}
