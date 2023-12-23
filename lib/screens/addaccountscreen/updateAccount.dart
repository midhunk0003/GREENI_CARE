import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/createAccount_model.dart';
import 'dart:io';
import 'package:greeni_care/db/account/account_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAccount extends StatefulWidget {
  final int addountID;
  final String username;
  final String imageFile;
  const UpdateAccount(this.addountID, this.username, this.imageFile, {Key? key})
      : super(key: key);

  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  int homeScreen = 0;
  late TextEditingController _nameController;
  File? _imagePath;
  final _formKey = GlobalKey<FormState>();
  late String username1;
  // late File? _imagePath;

  //passd value  for sho in fields
  String? username;
  String? imageFile;
  int? addountID;

  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _nameController.text = widget.username;
    ACCOUNTDB().getAccount().then((value) {
      print('account list home two1111111111 ${value}');
      setState(() {
        addountID = value?.id;
        username = value?.name;
        imageFile = value?.imagePath;
      });
    });
    print('account list user name home two ${username}');
    _imagePath;
    super.initState();
  }

  // insertRoomData(_cretroom);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Bottomnavigationbar(),
      backgroundColor: Color.fromARGB(227, 204, 219, 147),
      body: Form(
        key: _formKey,
        child: Column(
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
                        // RoutsManager.selectedIndexNotifier.value = homeScreen;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return RoutsManager();
                            },
                          ),
                          (route) => false,
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
                    Text(
                      'UPDATE ACCOUNT ${widget.addountID}',
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
                    Stack(
                      children: [
                        (_imagePath == null)
                            ? Container(
                                width: 144,
                                height: 129,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: FileImage(File(widget.imageFile)),
                                    // Replace with your image asset
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 144,
                                height: 129,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(_imagePath!.path))
                                        as ImageProvider,
                                    // Replace with your image asset
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                        Positioned(
                          top: 50,
                          right: 60,
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
                                                takePhoto(ImageSource.gallery,
                                                    context);
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
                                                takePhoto(ImageSource.camera,
                                                    context);
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
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    //text field
                    Padding(
                      padding: EdgeInsets.only(left: 46, right: 46),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          isCollapsed: true,
                          isDense: true,
                          hintText: 'NAME',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //add plant button
            InkWell(
              onTap: () {
                updateAcc(context);
                // fetchDataFromHive();
              },
              child: Container(
                width: 260,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 114, 122, 67),
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  'SAVE DATA',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  //take image function
  Future<void> takePhoto(ImageSource source, BuildContext context) async {
    // final picfile = await _picker.getImage(source: source);
    // final _image = await _picker.pickImage(source: source);
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePath = File(pickedFile.path);
      });
      Navigator.pop(context);
    } else {
      print('No image selected.');
    }
  }

  //add ACCOUNT to data base HIVE
  Future<void> updateAcc(BuildContext context) async {
    int id1 = widget.addountID;
    String? nameperson = _nameController.text;
    File? imagepath1 = _imagePath;
    String imageFetch = widget.imageFile;
    print(nameperson);
    print(imagepath1);
    print(imageFetch);
    if (imagepath1 == null) {
      final newUser = CreateAccountModel()
        ..id = id1
        ..name = nameperson
        ..imagePath = imageFetch;
      ACCOUNTDB().updateAccount(newUser, id1);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
        RoutsManager.selectedIndexNotifier.value = homeScreen;
        return RoutsManager();
      }), (route) => false);
    } else {
      final newUser = CreateAccountModel()
        ..id = id1
        ..name = nameperson
        ..imagePath = imagepath1.path;
      // add account function
      ACCOUNTDB().updateAccount(newUser, id1);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
        RoutsManager.selectedIndexNotifier.value = homeScreen;
        return RoutsManager();
      }), (route) => false);
    }
  }
}
