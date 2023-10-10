// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthStateStatusAdapter extends TypeAdapter<AuthStateStatus> {
  @override
  final int typeId = 3;

  @override
  AuthStateStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AuthStateStatus.initial;
      case 1:
        return AuthStateStatus.loading;
      case 2:
        return AuthStateStatus.loggedIn;
      case 3:
        return AuthStateStatus.logout;
      default:
        return AuthStateStatus.initial;
    }
  }

  @override
  void write(BinaryWriter writer, AuthStateStatus obj) {
    switch (obj) {
      case AuthStateStatus.initial:
        writer.writeByte(0);
        break;
      case AuthStateStatus.loading:
        writer.writeByte(1);
        break;
      case AuthStateStatus.loggedIn:
        writer.writeByte(2);
        break;
      case AuthStateStatus.logout:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStateStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
