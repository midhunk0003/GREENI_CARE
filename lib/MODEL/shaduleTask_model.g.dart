// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shaduleTask_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShaduleTaskModelAdapter extends TypeAdapter<ShaduleTaskModel> {
  @override
  final int typeId = 4;

  @override
  ShaduleTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShaduleTaskModel(
      id: fields[0] as int?,
      roomid: fields[1] as int,
      plantid: fields[2] as int,
      taskname: fields[3] as String,
      dateTime: fields[4] as DateTime,
      taskcomplete: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ShaduleTaskModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roomid)
      ..writeByte(2)
      ..write(obj.plantid)
      ..writeByte(3)
      ..write(obj.taskname)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.taskcomplete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShaduleTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
