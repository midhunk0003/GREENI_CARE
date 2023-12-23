import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/shaduleTask_model.dart';
import 'package:greeni_care/db/task/task_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:lottie/lottie.dart';

class PendingTasks extends StatefulWidget {
  const PendingTasks({Key? key}) : super(key: key);

  @override
  _PendingTasksState createState() => _PendingTasksState();
}

class _PendingTasksState extends State<PendingTasks> {
  late Box<AddPlantModel> plantsBox = Hive.box<AddPlantModel>('plant');
  late List<AddPlantModel> plantList = [];
  late List<CreateRoomModel> roomList = [];
  late List<dynamic> alllistplantandtask = [];
  late List<ShaduleTaskModel> pendingTask = [];
  late List<ShaduleTaskModel> completed = [];
  final _errormessage = 'DELETE PLANT SUCESS';

  @override
  void initState() {
    pendingTask;
    completed;
    AddTaskDB().pendingTasklist().then(
      (value) {
        print('all data frm 2 table : ${value}');
        setState(() {
          alllistplantandtask = value.toList();
        });
      },
    );
    AddTaskDB().pendingTask().then(
      (value) {
        setState(() {
          print('pending task : ${pendingTask}');
          pendingTask = value.toList();
        });
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(227, 204, 219, 147),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            int newIndex = 2;
                            RoutsManager.selectedIndexNotifier.value = newIndex;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (ctx) {
                              return RoutsManager();
                            }), (route) => false);
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
                            Text(
                              'PENDING TASK : (${pendingTask.length})',
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                                            return PendingTasks();
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
                                          color:
                                              Color.fromARGB(255, 228, 19, 19),
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
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                          color:
                                                              Colors.blueGrey,
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
                                                          print(
                                                              'task complete');
                                                          final updateTaskid =
                                                              alllistplantandtask[
                                                                  index]['id'];
                                                          final updatePlantid =
                                                              alllistplantandtask[
                                                                      index]
                                                                  ['plantid'];
                                                          final updateRoomid =
                                                              alllistplantandtask[
                                                                      index]
                                                                  ['roomid'];
                                                          final updateTaskname =
                                                              alllistplantandtask[
                                                                      index]
                                                                  ['taskname'];
                                                          final updateDatetime =
                                                              alllistplantandtask[
                                                                      index][
                                                                  'dateandtime'];
                                                          final updateCompleteTask =
                                                              alllistplantandtask[
                                                                      index][
                                                                  'taskcomplete'];
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
                                                          print(
                                                              'task complete');
                                                          final updateTaskid =
                                                              alllistplantandtask[
                                                                  index]['id'];
                                                          final updatePlantid =
                                                              alllistplantandtask[
                                                                      index]
                                                                  ['plantid'];
                                                          final updateRoomid =
                                                              alllistplantandtask[
                                                                      index]
                                                                  ['roomid'];
                                                          final updateTaskname =
                                                              alllistplantandtask[
                                                                      index]
                                                                  ['taskname'];
                                                          final updateDatetime =
                                                              alllistplantandtask[
                                                                      index][
                                                                  'dateandtime'];
                                                          final updateCompleteTask =
                                                              alllistplantandtask[
                                                                      index][
                                                                  'taskcomplete'];
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
        return PendingTasks();
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
          return PendingTasks();
        },
      ), (route) => false);
    }
  }
}
