import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/WIDGETS/bottom_sheet_addplant.dart';
import 'package:greeni_care/db/room/room_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';

class AddplantScreen extends StatefulWidget {
  const AddplantScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddplantScreenState createState() => _AddplantScreenState();
}

class _AddplantScreenState extends State<AddplantScreen> {
  PageController pageController = PageController();
  List<String> words = ['SHADE', 'PART SHADE', 'FULL SHADE'];
  final double doubleVal = 0;
  int newIndex = 0;
  String? shadeMode;

  late List<CreateRoomModel> roomListadd = [];

  @override
  void initState() {
    RoomDb().getRoom().then(
      (value) {
        print('add palnt in room');
        print(value);
        roomListadd = value;
      },
    );
    print('room list ${roomListadd}');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 45, top: 80, right: 45),
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
                    RoutsManager.selectedIndexNotifier.value = newIndex;
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
                const Text(
                  'Add Plant',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                //search bar
                Container(
                  height: 30,
                  child: TextField(
                    // controller: _searchController,
                    // onChanged: (value) {
                    //   setState(() {
                    //     _search();
                    //   });
                    // },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      isCollapsed: true,
                      isDense: true,
                      hintText: 'Search...',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.search, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //content text
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: const BoxDecoration(
                // color: Colors.white,
                ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SEARCH PLANT'),
                Text('OR ADD YOUR OWN PLANT'),
              ],
            ),
          ),
        ),
        //add plant button
        InkWell(
          onTap: () {
            // setState(
            //   () {
            setState(() {
              fetchShadeofsunshine(context, doubleVal);
              showBottomSheet1(context, roomListadd, words, shadeMode);
              // showBottomSheet(context);
            });

            //   },
            // );
          },
          child: Container(
            width: 260,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 114, 122, 67),
                borderRadius: BorderRadius.circular(50)),
            child: const Text(
              'I want to add \n my own plant',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchShadeofsunshine(context, doubleVal) async {
    print(doubleVal);
    if (doubleVal == 0.0) {
      shadeMode = 'SHADE';
    } else if (doubleVal == 1.0) {
      shadeMode = 'PARTSHADE';
    } else {
      shadeMode = 'FULLSHADE';
    }
    print(shadeMode);
  }
}
