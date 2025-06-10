// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibtihal_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IbtihalInfoAdapter extends TypeAdapter<IbtihalInfo> {
  @override
  final int typeId = 7;

  @override
  IbtihalInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IbtihalInfo(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IbtihalInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IbtihalInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
