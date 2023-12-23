import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/SCREENS/yourroomscreen/CreateRoom.dart';
import 'package:greeni_care/SCREENS/yourroomscreen/ViewCategoryRoom.dart';
import 'package:greeni_care/db/room/room_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:lottie/lottie.dart';

class ViewRoomEmpty extends StatefulWidget {
  const ViewRoomEmpty({Key? key}) : super(key: key);

  @override
  _ViewRoomEmptyState createState() => _ViewRoomEmptyState();
}

class _ViewRoomEmptyState extends State<ViewRoomEmpty> {
  int homeScreen = 0;
  late List<CreateRoomModel> searchResults = [];
  late TextEditingController _searchController;
  late List<AddPlantModel> plantlistroom = [];
  late List<CreateRoomModel> RoomList1 = [];

  late List<CreateRoomModel> RoomList = [];
  final _errormessage = 'DELETE ROOM SUCESS';

  var id;

  @override
  void initState() {
    _searchController = TextEditingController();
    RoomDb().getRoomBasedListPlant(id).then((value) {
      plantlistroom = value.toList();
      print('plant list room : ${plantlistroom}');
    });
    setState(() {
      _search();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (RoomList1.isEmpty) {
      /// is empty widget
      return Scaffold(
        // bottomNavigationBar: Bottomnavigationbar(),
        backgroundColor: Color.fromARGB(227, 204, 219, 147),
        body: Column(
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
                        RoutsManager.selectedIndexNotifier.value = homeScreen;
                        Navigator.of(context).pushReplacement(
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
                    const Text(
                      'ROOM',
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'asset/images/emptygifshadule.gif'))),
                      ),
                      Text('EMPTY ROOM'),
                    ],
                  )),
            ),
            //add plant button
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return CreateRoom();
                    },
                  ),
                );
              },
              child: Container(
                width: 260,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 114, 122, 67),
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  'ADD ROOM',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 30,
              ),
            )
          ],
        ),
      );
    } else {
      /// is not empty widget room
      return Scaffold(
        // bottomNavigationBar: Bottomnavigationbar(),
        backgroundColor: Color.fromARGB(227, 204, 219, 147),
        body: Column(
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
                        RoutsManager.selectedIndexNotifier.value = homeScreen;
                        Navigator.of(context).pushReplacement(
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
                          'ROOM',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return CreateRoom();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'ADD ROOM',
                            style: TextStyle(
                              color: Color.fromARGB(226, 121, 129, 89),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //search bar
                    Container(
                      height: 30,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _search();
                          });
                        },
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
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ///grid view room
            //content text
            (searchResults.isNotEmpty)
                ? Expanded(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          // color: Colors.white,
                          ),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        itemCount: searchResults.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: InkWell(
                                      onTap: () {
                                        print(index);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (ctx) {
                                          return ViewCategoryRoom(
                                              roomid: searchResults[index].id
                                                  as int,
                                              roomname:
                                                  searchResults[index].name);
                                        }));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 170,
                                            height: 170,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: const Color.fromARGB(
                                                        255, 49, 104, 51),
                                                    blurRadius: 20,
                                                    offset: Offset(0, 5))
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: FileImage(
                                                    File(searchResults[index]
                                                        .imagePath),
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),

                                          //deletebutton
                                          Positioned(
                                            top: 20,
                                            right: 20,
                                            child: InkWell(
                                              onTap: () {
                                                if (searchResults[index].id !=
                                                    null) {
                                                  setState(
                                                    () {
                                                      showDialog(
                                                        context: ctx,
                                                        builder: (ctx1) {
                                                          return Container(
                                                            width: 20,
                                                            height: 30,
                                                            color:
                                                                Color.fromARGB(
                                                                    38,
                                                                    41,
                                                                    37,
                                                                    25),
                                                            child: AlertDialog(
                                                              shape:
                                                                  RoundedRectangleBorder(),
                                                              backgroundColor:
                                                                  Color.fromRGBO(
                                                                      164,
                                                                      189,
                                                                      20,
                                                                      0.466),
                                                              content:
                                                                  Container(
                                                                width:
                                                                    300.0, // Set the width of the AlertDialog
                                                                height:
                                                                    200.0, // Set the height of the AlertDialog
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            50.0),
                                                                    Center(
                                                                        child:
                                                                            const Text(
                                                                      'DELETE YOUR ROOM',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                                    SizedBox(
                                                                        height:
                                                                            41.0),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              RoomDb().deleteRoomFunctionallplant(searchResults[index].id);
                                                                              setState(() {});
                                                                              Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx1) {
                                                                                return RoutsManager();
                                                                              }), (route) => false);
                                                                              final valueName = searchResults[index].name;
                                                                              showSnakebar(context, valueName);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            width:
                                                                                105,
                                                                            height:
                                                                                41,
                                                                            color: const Color.fromARGB(
                                                                                115,
                                                                                244,
                                                                                67,
                                                                                54),
                                                                            child:
                                                                                Text(
                                                                              'YES',
                                                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(ctx).pop();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            width:
                                                                                105,
                                                                            height:
                                                                                41,
                                                                            color: Color.fromARGB(
                                                                                87,
                                                                                23,
                                                                                95,
                                                                                20),
                                                                            child:
                                                                                Text(
                                                                              'NO',
                                                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  print('student id is null');
                                                }
                                              },
                                              child: Container(
                                                child: Image.asset(
                                                    'asset/images/deleteimg.png'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${searchResults[index].name}",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 46, 92, 47)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                    child: Center(
                      child: Text('NO ROOM FOUND'),
                    ),
                  )),
          ],
        ),
      );
    }
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

  Future<void> _search() async {
    final query = _searchController.text.toLowerCase();
    print("query: $query");
    RoomDb().getRoom().then((value) {
      print('rooms in list');
      print(value.toString());
      RoomList1 = value;
      print('romm new list : ${RoomList1}');
      searchResults = RoomList1.toList();
      setState(() {
        if (query.isEmpty) {
          print('empty called.');
          searchResults = value.toList();
        } else {
          print('setstate called.');
          searchResults = value.where((item) {
            return item.name.toLowerCase().contains(query);
          }).toList();
        }
      });
    });
  }
}
