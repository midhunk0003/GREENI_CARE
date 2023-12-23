import 'package:hive_flutter/hive_flutter.dart';

part 'addPlant_model.g.dart';

@HiveType(typeId: 3)
class AddPlantModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  late int roomid;
  @HiveField(2)
  late String shademode;
  @HiveField(3)
  late String plantname;
  @HiveField(4)
  late String imagePath;

  AddPlantModel({
    this.id,
    required this.roomid,
    required this.shademode,
    required this.plantname,
    required this.imagePath,
  });

  @override
  String toString() {
    return 'CreateAccountModel{id: $id,roomid : $roomid,plantname : $plantname , imagePath : $imagePath}';
  }

  toJson() {}
}
