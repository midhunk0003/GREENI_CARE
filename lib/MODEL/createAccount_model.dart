import 'package:hive_flutter/hive_flutter.dart';

part 'createAccount_model.g.dart';

@HiveType(typeId: 2)
class CreateAccountModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String imagePath;

  // CreateAccountModel({required this.name, required this.imagePath});

  @override
  String toString() {
    return 'CreateAccountModel{id : $id , name: $name, imagePath: $imagePath}';
  }
}
