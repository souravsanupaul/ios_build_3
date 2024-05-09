// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OTTModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OTTModelAdapter extends TypeAdapter<OTTModel> {
  @override
  final int typeId = 1;

  @override
  OTTModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OTTModel(
      ottName: fields[0] as String,
      websiteName: fields[1] as String,
      logoUrl: fields[2] as String,
      apiUrl: fields[3] as String,
      bucketUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OTTModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.ottName)
      ..writeByte(1)
      ..write(obj.websiteName)
      ..writeByte(2)
      ..write(obj.logoUrl)
      ..writeByte(3)
      ..write(obj.apiUrl)
      ..writeByte(4)
      ..write(obj.bucketUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OTTModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
