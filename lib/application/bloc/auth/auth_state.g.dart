// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthStateAdapter extends TypeAdapter<AuthState> {
  @override
  final int typeId = 4;

  @override
  AuthState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthState(
      currentUser: fields[2] as UserEntity,
      dataprotectionCheckbox: fields[3] as bool,
      token: fields[1] as String?,
      status: fields[0] as AuthStateStatus,
      sendedResetPasswordEmail: fields[4] as bool,
      sendedVerificationEmail: fields[5] as bool,
      userException: fields[6] as OperationException?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthState obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.currentUser)
      ..writeByte(3)
      ..write(obj.dataprotectionCheckbox)
      ..writeByte(4)
      ..write(obj.sendedResetPasswordEmail)
      ..writeByte(5)
      ..write(obj.sendedVerificationEmail)
      ..writeByte(6)
      ..write(obj.userException);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
