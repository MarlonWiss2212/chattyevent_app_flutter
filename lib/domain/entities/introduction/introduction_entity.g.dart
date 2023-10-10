// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introduction_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntroductionEntityAdapter extends TypeAdapter<IntroductionEntity> {
  @override
  final int typeId = 0;

  @override
  IntroductionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IntroductionEntity(
      appFeatureIntroduction: fields[0] as AppFeatureIntroductionEntity,
      appPermissionIntroduction: fields[1] as AppPermissionIntroductionEntity,
    );
  }

  @override
  void write(BinaryWriter writer, IntroductionEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.appFeatureIntroduction)
      ..writeByte(1)
      ..write(obj.appPermissionIntroduction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntroductionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
