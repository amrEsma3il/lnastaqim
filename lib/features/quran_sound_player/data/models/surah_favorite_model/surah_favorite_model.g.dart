// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurahFavoriteModelAdapter extends TypeAdapter<SurahFavoriteModel> {
  @override
  final int typeId = 3;

  @override
  SurahFavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurahFavoriteModel(
      surahNumber: fields[0] as int,
      surahName: fields[1] as String,
      reciter: fields[2] as Reciter,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SurahFavoriteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.surahNumber)
      ..writeByte(1)
      ..write(obj.surahName)
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
      other is SurahFavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
