import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greeni_care/MODEL/StarterModel.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createAccount_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/MODEL/shaduleTask_model.dart';
import 'package:greeni_care/SCREENS/splashscreen/SplashScreen.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StarterModelAdapter().typeId)) {
    Hive.registerAdapter(StarterModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CreateRoomModelAdapter().typeId)) {
    Hive.registerAdapter(CreateRoomModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CreateAccountModelAdapter().typeId)) {
    Hive.registerAdapter(CreateAccountModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AddPlantModelAdapter().typeId)) {
    Hive.registerAdapter(AddPlantModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ShaduleTaskModelAdapter().typeId)) {
    Hive.registerAdapter(ShaduleTaskModelAdapter());
  }
  // AddTaskDB().sheduleTask();

  final starterDB = await Hive.openBox<StarterModel>('starter_db');
  // starterDB.clear();

  final roomdb = await Hive.openBox<CreateRoomModel>('room');
  // roomdb.clear();

  final accountdb = await Hive.openBox<CreateAccountModel>('account');
  // accountdb.clear();

  final plantdb = await Hive.openBox<AddPlantModel>('plant');
  // plantdb.clear();
  // await Hive.box<CreateAccountModel>('account').close();

  final taskDb = await Hive.openBox<ShaduleTaskModel>('tasks');
  // taskDb.clear();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GREENI CARE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
