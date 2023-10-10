// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_feature_introduction_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppFeatureIntroductionEntityAdapter
    extends TypeAdapter<AppFeatureIntroductionEntity> {
  @override
  final int typeId = 2;

  @override
  AppFeatureIntroductionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppFeatureIntroductionEntity(
      finishedUsersPage: fields[0] as bool,
      finishedPrivateEventPage: fields[1] as bool,
      finishedGroupchatsPage: fields[2] as bool,
      finishedMessagesPage: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppFeatureIntroductionEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.finishedUsersPage)
      ..writeByte(1)
      ..write(obj.finishedPrivateEventPage)
      ..writeByte(2)
      ..write(obj.finishedGroupchatsPage)
      ..writeByte(3)
      ..write(obj.finishedMessagesPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppFeatureIntroductionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
