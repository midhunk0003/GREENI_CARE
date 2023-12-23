import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/SCREENS/addaccountscreen/addaccount.dart';
import 'package:greeni_care/SCREENS/addaccountscreen/updateAccount.dart';
import 'package:greeni_care/SCREENS/YOURROOMSCREEN/ViewRoomEmpty.dart';
import 'package:greeni_care/db/account/account_db.dart';
import 'package:greeni_care/db/room/room_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';

class HomeScreenOne extends StatefulWidget {
  HomeScreenOne({Key? key}) : super(key: key);

  @override
  State<HomeScreenOne> createState() => _HomeScreenOneState();
}

class _HomeScreenOneState extends State<HomeScreenOne> {
  final int screenadd = 1;

  int addPlantScreen = 1;
  int emptyRoom = 3;
  int notEmptyRoom = 4;
  String viewRoomEmpty = '';

  late List<CreateRoomModel> RoomList = [];

  int? addountID;
  String? username;
  String? imageFile;

  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour > 12 && hour < 15) {
      return 'Good afternoon';
    } else if (hour > 15 && hour < 18) {
      return 'Good evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  void initState() {
    getGreeting();
    RoomDb().getRoom().then((value) {
      print('rooms in list');
      print(value);
      setState(() {
        RoomList = value.toList();
      });
    });
    ACCOUNTDB().getAccount().then((value) {
      print('account list ${value}');
      setState(() {
        addountID = value?.id;
        username = value?.name;
        imageFile = value?.imagePath;
      });
    });
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 100,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (username == null)
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getGreeting(),
                                  style: TextStyle(
                                    fontSize: 27,
                                    color: Color.fromARGB(255, 117, 42, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'NAME',
                                  style: TextStyle(
                                    fontSize: 27,
                                    color: Color.fromARGB(255, 117, 42, 16),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getGreeting(),
                                  style: TextStyle(
                                    fontSize: 27,
                                    color: Color.fromARGB(255, 117, 42, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${username}',
                                  style: TextStyle(
                                    fontSize: 27,
                                    color: Color.fromARGB(255, 117, 42, 16),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    (imageFile == null)
                        ? InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (ctx) {
                                  return Addaccount();
                                }),
                              );
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('asset/images/profilgif.gif'),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (ctx) {
                                  return UpdateAccount(
                                      addountID!, username!, imageFile!);
                                }),
                              );
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  FileImage(File(imageFile!)) as ImageProvider,
                            ),
                          )
                  ],
                ),
              ),
            ),
            // const SizedBox(
            //   height: 200,
            // ),
            Expanded(
              flex: 3,
              child: Container(
                // color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 270,
                      width: 200,
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        image: DecorationImage(
                            image: AssetImage('asset/images/gifimghomeone.gif'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        RoutsManager.selectedIndexNotifier.value =
                            addPlantScreen;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return RoutsManager();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 259.47,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 114, 122, 67),
                        ),
                        child: const Center(
                          child: Text(
                            'ADD PLANTS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // if (viewRoomEmpty.isEmpty) {
                        //   RoutsManager.selectedIndexNotifier.value = addPlantScreen;
                        // } else {
                        //   RoutsManager.selectedIndexNotifier.value = notEmptyRoom;
                        // }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return ViewRoomEmpty();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 259.47,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 114, 122, 67),
                        ),
                        child: const Center(
                          child: Text(
                            'CREATE ROOM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
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
      ),
    );
  }
}
