// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_permission_introduction_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppPermissionIntroductionEntityAdapter
    extends TypeAdapter<AppPermissionIntroductionEntity> {
  @override
  final int typeId = 1;

  @override
  AppPermissionIntroductionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppPermissionIntroductionEntity(
      finishedMicrophonePage: fields[1] as bool,
      finishedNotificationPage: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppPermissionIntroductionEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.finishedNotificationPage)
      ..writeByte(1)
      ..write(obj.finishedMicrophonePage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPermissionIntroductionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
