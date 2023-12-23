import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/db/addplant/addplant_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:image_picker/image_picker.dart';

PageController pageController = PageController();
TextEditingController _nameController = TextEditingController();

final double doubleVal = 0;
int newIndex = 0;
File? _image;
String? shadeMode1;
final _formKey = GlobalKey<FormState>();
late List<CreateRoomModel> roomListadd1 = [];
int? _roomId;
Future<void> showBottomSheet1(
  BuildContext ctx,
  List<CreateRoomModel> valueroom,
  List<String> words,
  String? shadeMode,
) async {
  shadeMode1 = shadeMode;
  roomListadd1 = valueroom;
  print(valueroom);
  print(words);
  print(pageController);
  print('sfsfdfdffdf : ${shadeMode}');
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
    context: ctx,
    builder: (ctx1) {
      return Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          height: 700,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 114, 122, 67),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: 260,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 114, 122, 67),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    'Add your own Plant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //addplant text
                //addplant Textfield
                const Align(
                  child: Text(
                    'Whats the name of your plant?',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  // decoration: BoxDecoration(
                  //   color: const Color.fromARGB(255, 228, 226, 226),
                  //   borderRadius: BorderRadius.circular(30),
                  // ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0, // Set vertical padding to 0
                        horizontal: 10.0, // Adjust horizontal padding as needed
                      ),
                      // contentPadding: EdgeInsets.all(15),
                      // isCollapsed: true,
                      // isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 228, 226, 226),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'please e1 nter plant name';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                ),

                //select room
                const Align(
                  child: Text(
                    'Room',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(
                  height: 10,
                ),
                StatefulBuilder(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 228, 226, 226),
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        child: DropdownButton(
                          hint: (roomListadd1.isEmpty)
                              ? Text('ROOM IS EMPTY PLEASE ADD ROOM FIRST')
                              : Text('SELECT ROOM'),
                          dropdownColor: Color.fromARGB(255, 169, 182, 99),
                          elevation: 5,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          isExpanded: true,
                          value: _roomId,
                          items: roomListadd1.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name),
                            );
                          }).toList(),
                          onChanged: (selectedValue) {
                            state(() {
                              _roomId = selectedValue;
                              print(_roomId);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  child: Text(
                    'Sun shine',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),

                ///slider
                StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: [
                        Container(
                          height: 30, // Set a fixed height for the container
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: words.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(
                                  words[index],
                                  style: const TextStyle(fontSize: 24.0),
                                ),
                              );
                            },
                            onPageChanged: (index) {
                              // Do something when the page changes
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StatefulBuilder(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Slider(
                          value: pageController.page ?? 0,
                          onChanged: (value) {
                            final doubleVal = pageController.page;
                            state(() {
                              fetchShadeofsunshine(context, doubleVal);
                              pageController.jumpToPage(value.toInt());
                            });
                          },
                          activeColor: Color.fromARGB(255, 156, 172, 69),
                          min: 0,
                          max: words.length - 1.0,
                        ),
                      ],
                    );
                  },
                ),

                StatefulBuilder(
                  builder: (context, setState) {
                    return // addimage
                        Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _image == null
                                  ? AssetImage('asset/images/profileimgdum.png')
                                  : FileImage(File(_image!.path))
                                      as ImageProvider,
                              // Replace with your image asset
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 30,
                          right: 30,
                          child: InkWell(
                            onTap: () {
                              print('dfdsf');
                              showModalBottomSheet(
                                backgroundColor:
                                    const Color.fromARGB(255, 122, 185, 124),
                                context: context,
                                builder: (ctx) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(
                                                  () {
                                                    takePhoto(
                                                        ImageSource.gallery,
                                                        context);
                                                    _image;
                                                  },
                                                );
                                              },
                                              child: SizedBox(
                                                  child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                    size: 70,
                                                  ),
                                                  Text('Gallery')
                                                ],
                                              )),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(
                                                  () {
                                                    takePhoto(
                                                        ImageSource.camera,
                                                        context);
                                                    _image;
                                                  },
                                                );
                                              },
                                              child: SizedBox(
                                                  child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    size: 70,
                                                  ),
                                                  Text('Camera')
                                                ],
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset('asset/images/Plus_Math.png'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // if (_formKey.currentState!.validate()) {
                    savePlant(ctx);
                    //after plant add clear all field variable
                    _nameController.text = '';
                    _roomId = null;
                    _image = null;
                    // } else {
                    //   print('no data');
                    // }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 156, 172, 69),
                    ),
                    child: Center(child: Text('save plant')),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//take image function

Future<void> takePhoto(ImageSource source, BuildContext context) async {
  // final picfile = await _picker.getImage(source: source);
  // final _image = await _picker.pickImage(source: source);
  final pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile != null) {
    _image = File(pickedFile.path);
    Navigator.pop(context);
  } else {
    print('No image selected.');
  }
}

void showSnakebar(BuildContext context) {
  String _errormessage = 'please select image';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 211, 25, 25),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 400, left: 20, right: 20),
        content: Text(_errormessage)),
  );
}

void showSnakebar2(BuildContext context) {
  String _errormessage = 'PLEASE select room';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 211, 25, 25),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 400, left: 20, right: 20),
        content: Text(_errormessage)),
  );
}

void showSnakebar3(BuildContext context) {
  String _errormessage = 'PLEASE ENTER PLANT NAME';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 211, 25, 25),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 400, left: 20, right: 20),
        content: Text(_errormessage)),
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

Future<void> savePlant(BuildContext context) async {
  final nameplant = _nameController.text;
  final roomidsave = _roomId;
  final shadeModesave = shadeMode1;
  File? _imagepath = _image;

  print('roomasas id save : ${nameplant}');
  print('room id save : ${roomidsave}');
  print('room id save : ${shadeModesave}');
  print('room image id save : ${_imagepath}');

  if (nameplant.isEmpty) {
    showSnakebar3(context);
    print('no name');
  } else {
    if (roomidsave == null) {
      showSnakebar2(context);
      print('noroomid');
    } else {
      if (_imagepath == null) {
        showSnakebar(context);
        print('no image');
      } else {
        //  for getting id from the table thats why call getPlant object function
        print('svae img');
        AddPlantDB().getPlant().then((value) {
          final iu1 = value.toList();
          final id = iu1.isEmpty ? 1 : iu1.last.id! + 1;
          final adplants = AddPlantModel(
            id: id,
            roomid: roomidsave,
            shademode: shadeModesave!,
            plantname: nameplant,
            imagePath: _imagepath.path,
          );
          AddPlantDB().insertPlant(adplants);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) {
            return RoutsManager();
          }), (route) => false);
        });
      }
    }
  }
}
