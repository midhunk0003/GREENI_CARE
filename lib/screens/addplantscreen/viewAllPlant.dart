import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/db/addplant/addplant_db.dart';
import 'package:greeni_care/db/room/room_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:greeni_care/widgets/bottom_sheet_addplant.dart';
import 'package:greeni_care/widgets/foreditbottomsheet.dart';

class ViewAllPlant extends StatefulWidget {
  const ViewAllPlant({Key? key}) : super(key: key);

  @override
  _ViewAllPlantState createState() => _ViewAllPlantState();
}

class _ViewAllPlantState extends State<ViewAllPlant> {
  late TextEditingController _searchController;
  late List<AddPlantModel> searchResults = [];
  late List<AddPlantModel> plantlistroom = [];
  final _errormessage = 'DELETE  SUCESS';
  List<String> roomname = [];
  late List<CreateRoomModel> roomListadd = [];
  List<String> words = ['SHADE', 'PART SHADE', 'FULL SHADE'];
  final double doubleVal = 0;
  String? shadeMode1;
  @override
  void initState() {
    _searchController = TextEditingController();
    RoomDb().getRoom().then(
      (value) {
        print('add palnt in room');
        print(value);
        roomListadd = value;
      },
    );
    print('room list ${roomListadd}');
    _search();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Bottomnavigationbar(),
      backgroundColor: Color.fromARGB(227, 204, 219, 147),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Container(
                // height: 130,
                width: double.infinity,
                // color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // back button
                    InkWell(
                      onTap: () {
                        int homeScreen = 0;
                        RoutsManager.selectedIndexNotifier.value = homeScreen;

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                          builder: (ctx) {
                            return RoutsManager();
                          },
                        ), (route) => false);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'YOUR GARDEN',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (ctx) {
                            //       return CreateRoom();
                            //     },
                            //   ),
                            // );
                          },
                          child: Text(
                            'ADD Plant',
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
                    ),
                  ],
                ),
              ),
              // top container end

              ///list of plant container start
              (searchResults.isNotEmpty)
                  ? Expanded(
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        // color: Color.fromARGB(206, 240, 240, 240),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 10, bottom: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(225, 75, 90, 15),
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: ListTile(
                                title: Text(
                                  '${searchResults[index].plantname}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${roomname[index]}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: FileImage(File(
                                            searchResults[index].imagePath)),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                trailing: Container(
                                    width: 100,
                                    height: double.infinity,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print('edit');
                                            setState(() {
                                              List<dynamic>
                                                  editListpassplantdata = [
                                                searchResults[index].id,
                                                searchResults[index].plantname,
                                                searchResults[index].roomid,
                                                searchResults[index].shademode,
                                                searchResults[index].imagePath,
                                              ];
                                              fetchShadeofsunshine(
                                                  context, doubleVal);

                                              editaddplantbottomsheet(
                                                context,
                                                roomListadd,
                                                words,
                                                shadeMode1,
                                                editListpassplantdata,
                                              );
                                            });
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              // color: Colors.amber,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'asset/images/editimg.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print('delete plant in room');
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) {
                                                    return Container(
                                                      width: 20,
                                                      height: 30,
                                                      color: Color.fromARGB(
                                                          38, 41, 37, 25),
                                                      child: AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(),
                                                        backgroundColor:
                                                            Color.fromRGBO(164,
                                                                189, 20, 0.466),
                                                        content: Container(
                                                          width:
                                                              300.0, // Set the width of the AlertDialog
                                                          height:
                                                              200.0, // Set the height of the AlertDialog
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: 50.0),
                                                              Center(
                                                                  child:
                                                                      const Text(
                                                                'DELETE YOUR PLANT IN ROOM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                              SizedBox(
                                                                  height: 41.0),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                        () {
                                                                          AddPlantDB()
                                                                              .deletePlantinGarden(searchResults[index].id);
                                                                          AddPlantDB()
                                                                              .taskdeletewhenplantdelete(searchResults[index].id);
                                                                          print(
                                                                              'room id in all palnt : ${searchResults[index].roomid}');
                                                                          Navigator.pushAndRemoveUntil(
                                                                              context,
                                                                              MaterialPageRoute(builder: (ctx) {
                                                                            return ViewAllPlant();
                                                                          }), (route) => false);
                                                                        },
                                                                      );
                                                                      showSnakebar(context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width:
                                                                          105,
                                                                      height:
                                                                          41,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          115,
                                                                          244,
                                                                          67,
                                                                          54),
                                                                      child:
                                                                          Text(
                                                                        'YES',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              ctx)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width:
                                                                          105,
                                                                      height:
                                                                          41,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              87,
                                                                              23,
                                                                              95,
                                                                              20),
                                                                      child:
                                                                          Text(
                                                                        'NO',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
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
                                                  });
                                            });
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              // color: Colors.amber,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'asset/images/deleteimg.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                      child: Center(child: Text('NO DATA FOUND')),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchShadeofsunshine(context, doubleVal) async {
    print(doubleVal);
    if (doubleVal == 0.0) {
      shadeMode1 = 'SHADE';
    } else if (doubleVal == 1.0) {
      shadeMode1 = 'PARTSHADE';
    } else {
      shadeMode1 = 'FULLSHADE';
    }
    print(shadeMode1);
  }

  void showSnakebar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 150, 38, 38),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(40),
          content: Text(_errormessage)),
    );
  }

  Future<void> _search() async {
    final query = _searchController.text.toLowerCase();
    print("query: $query");

    AddPlantDB().getKitchenName().then((value) {
      print('kitchen name : $value');

      roomname = value.toList();
    });

    AddPlantDB().getPlant().then((value) {
      plantlistroom = value.toList();

      searchResults = plantlistroom.toList();
      setState(() {
        if (query.isEmpty) {
          print('empty called.');
          searchResults = value.toList();
        } else {
          print('setstate called.');
          searchResults = value.where((item) {
            return item.plantname.toLowerCase().contains(query);
          }).toList();
        }
      });
    });
  }
}
