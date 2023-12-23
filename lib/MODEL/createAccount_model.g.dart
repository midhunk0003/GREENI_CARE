// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createAccount_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateAccountModelAdapter extends TypeAdapter<CreateAccountModel> {
  @override
  final int typeId = 2;

  @override
  CreateAccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateAccountModel()
      ..id = fields[0] as int?
      ..name = fields[1] as String
      ..imagePath = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, CreateAccountModel obj) {
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
      other is CreateAccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
