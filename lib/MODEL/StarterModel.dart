import 'package:hive/hive.dart';

part 'StarterModel.g.dart';
@HiveType(typeId: 0)
class StarterModel {
  @HiveField(0)
  final String starterClick;

  StarterModel({required this.starterClick});
}
