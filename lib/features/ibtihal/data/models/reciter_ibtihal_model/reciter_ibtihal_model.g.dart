// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciter_ibtihal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReciterIbtihalModelAdapter extends TypeAdapter<ReciterIbtihalModel> {
  @override
  final int typeId = 6;

  @override
  ReciterIbtihalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReciterIbtihalModel(
      id: fields[0] as int,
      name: fields[1] as String,
      nameArabic: fields[2] as String,
      nationality: fields[3] as String,
      info: (fields[4] as List).cast<IbtihalInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReciterIbtihalModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nameArabic)
      ..writeByte(3)
      ..write(obj.nationality)
      ..writeByte(4)
      ..write(obj.info);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReciterIbtihalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
