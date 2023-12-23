// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addPlant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddPlantModelAdapter extends TypeAdapter<AddPlantModel> {
  @override
  final int typeId = 3;

  @override
  AddPlantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddPlantModel(
      id: fields[0] as int?,
      roomid: fields[1] as int,
      shademode: fields[2] as String,
      plantname: fields[3] as String,
      imagePath: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddPlantModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roomid)
      ..writeByte(2)
      ..write(obj.shademode)
      ..writeByte(3)
      ..write(obj.plantname)
      ..writeByte(4)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddPlantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
