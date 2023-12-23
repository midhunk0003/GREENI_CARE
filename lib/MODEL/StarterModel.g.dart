// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StarterModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StarterModelAdapter extends TypeAdapter<StarterModel> {
  @override
  final int typeId = 0;

  @override
  StarterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StarterModel(
      starterClick: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StarterModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.starterClick);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
