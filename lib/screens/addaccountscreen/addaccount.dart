import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/createAccount_model.dart';
import 'dart:io';
import 'package:greeni_care/db/account/account_db.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:image_picker/image_picker.dart';

class Addaccount extends StatefulWidget {
  const Addaccount({Key? key}) : super(key: key);

  @override
  _AddaccountState createState() => _AddaccountState();
}

class _AddaccountState extends State<Addaccount> {
  int homeScreen = 0;
  late TextEditingController _nameController;
  File? _imagePath;
  final _formKey = GlobalKey<FormState>();
  late String username;
  late File? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _imagePath;
  }

// take pick image from camera and path save to varubla
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imagePath = File(pickedFile.path);
      });
    }
  }

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
                        ), (route) => true);
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
                      'CREATE ACCOUNT',
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
                if (_formKey.currentState!.validate()) {
                  addAccount(context);
                } else {
                  print('data empty');
                }
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

  void showSnakebar(BuildContext context) {
    String _errormessage = 'please select image';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 212, 8, 8),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(40),
          content: Text(_errormessage)),
    );
  }

  //add ACCOUNT to data base HIVE
  Future<void> addAccount(BuildContext context) async {
    String? nameperson = _nameController.text;
    File? imagepath1 = _imagePath;
    print(nameperson);
    print(imagepath1);
    if (imagepath1 == null) {
      showSnakebar(context);
      print('no image');
    } else {
      final newUser = CreateAccountModel()
        ..id = 1
        ..name = nameperson
        ..imagePath = imagepath1.path;
      // add account function
      ACCOUNTDB().insertAccount(newUser);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
        RoutsManager.selectedIndexNotifier.value = homeScreen;
        return RoutsManager();
      }), (route) => false);
    }
  }
}
