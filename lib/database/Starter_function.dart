import 'package:greeni_care/MODEL/StarterModel.dart';
import 'package:hive_flutter/adapters.dart';

var starterScreen = [];

Future<void> addNameStarter(StarterModel value) async {
  //starterScreen.add(value);
  final starterDB = await Hive.openBox<StarterModel>('starter_db');
  await starterDB.add(value);
  print(
    starterScreen.toString(),
  );
}
