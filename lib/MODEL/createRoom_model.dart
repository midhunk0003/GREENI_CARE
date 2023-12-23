import 'package:hive_flutter/hive_flutter.dart';
part 'createRoom_model.g.dart';

@HiveType(typeId: 1)
class CreateRoomModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  late String imagePath;

  CreateRoomModel({this.id, required this.name, required this.imagePath});

  // Override toString method
  @override
  String toString() {
    return 'CreateRoomModel{id : $id ,name: $name, imagePath: $imagePath}';
  }
}
