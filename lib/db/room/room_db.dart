import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/addPlant_model.dart';
import 'package:greeni_care/MODEL/createRoom_model.dart';
import 'package:greeni_care/MODEL/shaduleTask_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const ROOM_DB_NAME = 'room';

abstract class RoomDbFunction {
  Future<List<CreateRoomModel>> getRoom();
  Future<List<AddPlantModel>> getRoomBasedListPlant(id);
  Future<void> insertRoom(CreateRoomModel value);
  Future<void> deleteRoomFunctionallplant(int? roomid);
}

class RoomDb implements RoomDbFunction {
  @override
  Future<void> insertRoom(CreateRoomModel value) async {
    final _roomDB = await Hive.openBox<CreateRoomModel>(ROOM_DB_NAME);
    await _roomDB.put(value.id, value);
  }

  @override
  Future<List<CreateRoomModel>> getRoom() async {
    final _roomDB = await Hive.openBox<CreateRoomModel>(ROOM_DB_NAME);
    return _roomDB.values.toList();
  }

  @override
  Future<void> deleteRoomFunctionallplant(roomid) async {
    print('id new : ${roomid.toString()}');
    var roomBox = await Hive.openBox<CreateRoomModel>('room');
    var plantBox = await Hive.openBox<AddPlantModel>('plant');
    var taskBox = await Hive.openBox<ShaduleTaskModel>('tasks');
    // Get the room
    var room = roomBox.get(roomid);
    if (room != null) {
      // Delete plants associated with the room
      var plantsTodelete =
          plantBox.values.where((plant) => plant.roomid == roomid).toList();
      await Future.forEach(plantsTodelete, (plant) async {
        await plantBox.delete(plant.id);
      });
      var taskTodelete =
          taskBox.values.where((task) => task.roomid == roomid).toList();
      await Future.forEach(taskTodelete, (task) async {
        print('when delete room task also delete :${taskTodelete}');
        await taskBox.delete(task.id);
      });
      //delete room itself
      await roomBox.delete(roomid);
    }
  }

  @override
  Future<List<AddPlantModel>> getRoomBasedListPlant(id) async {
    final plantDb = await Hive.openBox<AddPlantModel>('plant');
    final plantdeletebasedonroom =
        plantDb.values.where((element) => element.roomid == id).toList();

    print('based on room ${plantdeletebasedonroom}');
    return plantDb.values.where((element) => element.roomid == id).toList();
  }
}
