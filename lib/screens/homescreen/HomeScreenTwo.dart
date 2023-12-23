import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/MODEL/shaduleTask_model.dart';
import 'package:greeni_care/SCREENS/addaccountscreen/addaccount.dart';
import 'package:greeni_care/SCREENS/addaccountscreen/updateAccount.dart';
import 'package:greeni_care/SCREENS/addplantscreen/viewAllPlant.dart';
import 'package:greeni_care/SCREENS/YOURROOMSCREEN/ViewRoomEmpty.dart';
import 'package:greeni_care/db/account/account_db.dart';
import 'package:greeni_care/db/addplant/addplant_db.dart';
import 'package:greeni_care/db/room/room_db.dart';
import 'package:greeni_care/db/task/task_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:lottie/lottie.dart';

class HomeScreenTwo extends StatefulWidget {
  const HomeScreenTwo({Key? key}) : super(key: key);

  @override
  _HomeScreenTwoState createState() => _HomeScreenTwoState();
}

class _HomeScreenTwoState extends State<HomeScreenTwo> {
  int mycurentIndex = 0;
  late List<dynamic> last2data = [];
  late List<CreateRoomModel> roomList = [];
  late List<AddPlantModel> plantlist = [];
  String? username;
  String? imageFile;
  int? addountID;
  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour > 12 && hour < 15) {
      return 'Good afternoon';
    } else if (hour > 15 && hour < 17) {
      return 'Good evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  void initState() {
    getGreeting();

    AddTaskDB().getLast2data().then(
      (value) {
        print('last 2 data ${value}');
        setState(() {
          last2data = value.toList();
        });
      },
    );
    RoomDb().getRoom().then((value) {
      print('room db value ${value.toList()}');
      setState(() {
        roomList = value.toList();
      });
    });
    AddPlantDB().getPlant().then((value) {
      print('planr list new ${value.toList()}');
      setState(() {
        plantlist = value.toList();
      });
    });

    ACCOUNTDB().getAccount().then((value) {
      print('account list home two ${value}');
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                            Navigator.of(context).push(
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return UpdateAccount(
                                      addountID!, username!, imageFile!);
                                },
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                FileImage(File(imageFile!)) as ImageProvider,
                          ),
                        ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today’s tasks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  int newIndex = 2;
                  RoutsManager.selectedIndexNotifier.value = newIndex;
                  print('see more');
                },
                child: Text('See More'),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          (last2data.length == 1 || last2data.length == 2)
              ? Expanded(
                  child: Container(
                  // color: Colors.blue,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: last2data.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: FileImage(File(
                                              last2data[index]['plantimg'])),
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
                                            '${last2data[index]['taskname']} ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${last2data[index]['plantname']} ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                ': (${last2data[index]['roomname']})',
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
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
                                  (last2data[index]['taskcomplete'] == 2)
                                      ? Expanded(
                                          child: Container(
                                            // color: Colors.black,
                                            child: IconButton(
                                              onPressed: () {},
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
                                              onPressed: () {},
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
                      );
                    },
                  ),
                ))
              : Expanded(
                  child: InkWell(
                  onTap: () {
                    int addPlantScreen = 2;
                    RoutsManager.selectedIndexNotifier.value = addPlantScreen;
                  },
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 49, 104, 51),
                              blurRadius: 10,
                              offset: Offset(0, 5))
                        ],
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('TASK IS EMPTY'),
                          LottieBuilder.asset(
                              'asset/animations/emptytask.json'),
                        ],
                      ),
                    ),
                  ),
                )),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Rooms',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return ViewRoomEmpty();
                      },
                    ),
                  );
                  print('view room');
                },
                child: Text('See More'),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              // color: Color.fromARGB(255, 17, 28, 96),
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return ViewRoomEmpty();
                      },
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 49, 104, 51),
                          blurRadius: 20,
                          offset: Offset(0, 5))
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: EdgeInsets.all(20),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 140, 126, 84),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 49, 104, 51),
                                blurRadius: 10,
                                offset: Offset(0, 5))
                          ],
                          image: DecorationImage(
                            image: FileImage(File(roomList[index].imagePath)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: roomList.length,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your plants',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) {
                    return ViewAllPlant();
                  }), (route) => false);
                  print('view room');
                },
                child: Text('See More'),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          (plantlist.isEmpty)
              ? Expanded(
                  child: InkWell(
                    onTap: () {
                      int addPlantScreen = 1;
                      RoutsManager.selectedIndexNotifier.value = addPlantScreen;
                      print('your plants');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 49, 104, 51),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('PLANT IS EMPTY'),
                          LottieBuilder.asset(
                              'asset/animations/emptytask.json'),
                        ],
                      )),
                    ),
                  ),
                )
              : Expanded(
                  child: InkWell(
                    onTap: () {
                      AddPlantDB().getKitchenName().then((value) {
                        print('kitchen name : $value');
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (ctx) {
                        return ViewAllPlant();
                      }), (route) => false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 49, 104, 51),
                              blurRadius: 10,
                              offset: Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.all(20),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 140, 126, 84),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 49, 104, 51),
                                    blurRadius: 10,
                                    offset: Offset(0, 5))
                              ],
                              image: DecorationImage(
                                image:
                                    FileImage(File(plantlist[index].imagePath)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        itemCount: plantlist.length,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
