// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createRoom_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateRoomModelAdapter extends TypeAdapter<CreateRoomModel> {
  @override
  final int typeId = 1;

  @override
  CreateRoomModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateRoomModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      imagePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreateRoomModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateRoomModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
