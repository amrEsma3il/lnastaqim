// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      ayahNumInQuran: fields[4] as int,
      note: fields[0] as String,
      ayahNum: fields[1] as int,
      pageNum: fields[2] as String,
      surahName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.note)
      ..writeByte(1)
      ..write(obj.ayahNum)
      ..writeByte(2)
      ..write(obj.pageNum)
      ..writeByte(3)
      ..write(obj.surahName)
      ..writeByte(4)
      ..write(obj.ayahNumInQuran);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
