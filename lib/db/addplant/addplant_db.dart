import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/MODEL/shaduleTask_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const ADDPLANT_DB_NAME = 'plant';

abstract class AddPlantDbFunction {
  Future<List<AddPlantModel>> getPlant();
  Future<void> insertPlant(AddPlantModel value);
  Future<void> deletePlantinRoom(roomidpass);
  Future<void> deletePlantinGarden(id);
  Future<List<String>> getKitchenName();
  Future<void> taskdeletewhenplantdelete(plantid);
}

class AddPlantDB implements AddPlantDbFunction {
  @override
  Future<void> insertPlant(AddPlantModel value) async {
    final _plantDB = await Hive.openBox<AddPlantModel>(ADDPLANT_DB_NAME);
    await _plantDB.put(value.id, value);
    print('new plant ${value.toString()}');
  }

  @override
  Future<List<AddPlantModel>> getPlant() async {
    final _plantDB = await Hive.openBox<AddPlantModel>(ADDPLANT_DB_NAME);
    return _plantDB.values.toList();
  }

  Future<List<String>> getKitchenName() async {
    List<int> ids = [];
    List<String> plantName = [];

    final _plantDb = await Hive.openBox<AddPlantModel>('plant');
    final _roomDb = await Hive.openBox<CreateRoomModel>('room');

    for (var i = 0; i < _plantDb.length; i++) {
      var modelInstance = _plantDb.getAt(i);
      if (modelInstance != null) {
        ids.add(modelInstance.roomid);
      }
    }
    print(ids);

    for (var i = 0; i < ids.length; i++) {
      var room = _roomDb.values.firstWhere((element) => element.id == ids[i]);
      plantName.add(room.name);
    }

    print('Rooms: $plantName');
    return plantName;
  }

  @override
  Future<void> deletePlantinRoom(id) async {
    print('room id in plant ${id}');
    final plantDb = await Hive.openBox<AddPlantModel>(ADDPLANT_DB_NAME);
    // final plantdeletebasedonroom =
    //await plantDb.values.where((element) => element.roomid == roomidpass).toList();
    // print('based on room ${plantdeletebasedonroom}');
    plantDb.delete(id);
  }

  @override
  Future<void> deletePlantinGarden(id) async {
    print('room id in plant ${id}');
    final plantDb = await Hive.openBox<AddPlantModel>(ADDPLANT_DB_NAME);
    // final plantdeletebasedonroom =
    //     await plantDb.values.where((element) => element.roomid == id);
    // print('based on room ${plantdeletebasedonroom}');
    plantDb.delete(id);
  }

  Future<void> taskdeletewhenplantdelete(plantidinplantid) async {
    print('plant id : ${plantidinplantid}');
    final taskDb = await Hive.openBox<ShaduleTaskModel>('tasks');
    // final plantdeletebasedonroom = await taskDb.values
    //     .where((element) => element.plantid == plantidinplantid);
    // print('task list : ${plantdeletebasedonroom}');
    taskDb.delete(plantidinplantid);
  }

  Future<void> updateplant(AddPlantModel values) async {
    final plantDb = await Hive.openBox<AddPlantModel>(ADDPLANT_DB_NAME);
    await plantDb.put(values.id, values);
    print('update $values');
  }
}
