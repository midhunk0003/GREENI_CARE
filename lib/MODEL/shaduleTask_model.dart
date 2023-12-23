import 'package:hive_flutter/hive_flutter.dart';

part 'shaduleTask_model.g.dart';

@HiveType(typeId: 4)
class ShaduleTaskModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  late int roomid;
  @HiveField(2)
  late int plantid;
  @HiveField(3)
  late String taskname;
  @HiveField(4)
  late DateTime dateTime;
  @HiveField(5)
  final int taskcomplete;

  ShaduleTaskModel({
    required this.id,
    required this.roomid,
    required this.plantid,
    required this.taskname,
    required this.dateTime,
    required this.taskcomplete,
  });

  @override
  String toString() {
    return 'CreateRoomModel{id : $id , roomid: $roomid ,plant id : $plantid, taskname: $taskname,datetime : $dateTime}. taskcomplete : $taskcomplete';
  }

  toJson() {}

  delete([int? id]) {}
}
