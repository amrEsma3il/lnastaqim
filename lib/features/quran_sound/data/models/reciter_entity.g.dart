// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciter_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReciterEntityAdapter extends TypeAdapter<ReciterEntity> {
  @override
  final int typeId = 8;

  @override
  ReciterEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReciterEntity(
      reciter: fields[0] as String,
      downloadUrl: fields[1] as String,
      arabicName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReciterEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.reciter)
      ..writeByte(1)
      ..write(obj.downloadUrl)
      ..writeByte(2)
      ..write(obj.arabicName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReciterEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
