// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibtihal_fav_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IbtihalFavoriteModelAdapter extends TypeAdapter<IbtihalFavoriteModel> {
  @override
  final int typeId = 5;

  @override
  IbtihalFavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IbtihalFavoriteModel(
      ibtihalNumber: fields[0] as int,
      ibtihalName: fields[1] as String,
      reciter: fields[2] as ReciterIbtihalModel,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IbtihalFavoriteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ibtihalNumber)
      ..writeByte(1)
      ..write(obj.ibtihalName)
      ..writeByte(2)
      ..write(obj.reciter)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IbtihalFavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
