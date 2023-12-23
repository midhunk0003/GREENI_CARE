import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/SCREENS/addplantscreen/AddplantScreen.dart';
import 'package:greeni_care/SCREENS/homescreen/HomeScreenOne.dart';
import 'package:greeni_care/SCREENS/homescreen/HomeScreenTwo.dart';
import 'package:greeni_care/SCREENS/todoreminderscreen/TodotaskScreen.dart';
import 'package:greeni_care/SCREENS/YOURROOMSCREEN/ViewRoomEmpty.dart';
import 'package:greeni_care/WIDGETS/Bottomnavigationbar.dart';
import 'package:greeni_care/db/room/room_db.dart';

class RoutsManager extends StatefulWidget {
  RoutsManager({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<RoutsManager> createState() => _RoutsManagerState();
}

class _RoutsManagerState extends State<RoutsManager> {
  //dumy var
  String homeVal = '';

  List pages = [
    HomeScreenOne(),
    AddplantScreen(),
    TodotaskScreen(),
    ViewRoomEmpty(),
  ];

  List pageshometwo = [
    HomeScreenTwo(),
    AddplantScreen(),
    TodotaskScreen(),
    ViewRoomEmpty(),
  ];
  late List<CreateRoomModel> roomList = [];

  @override
  void initState() {
    RoomDb().getRoom().then((value) {
      print('room db value ${value.toList()}');
      setState(() {
        roomList = value;
      });
    });
    // fetchDataFromRoom();
    // TODO: implement initState
    super.initState();
  }

  // Future<void> fetchDataFromRoom() async {
  //   final RoomDataDB = await Hive.openBox<CreateRoomModel>('room');
  //   setState(() {
  //     RoomList = RoomDataDB.values.toList();
  //   });
  //   print(RoomList);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(227, 204, 219, 147),
      // backgroundColor: Color.fromARGB(226, 179, 214, 38),
      bottomNavigationBar: Bottomnavigationbar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: RoutsManager.selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, _) {
            if (roomList.isEmpty) {
              print(updateIndex);
              return pages[updateIndex];
            } else {
              return pageshometwo[updateIndex];
            }
          },
        ),
      ),
    );
  }
}
