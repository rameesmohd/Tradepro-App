// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginModelAdapter extends TypeAdapter<LoginModel> {
  @override
  final int typeId = 0;

  @override
  LoginModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginModel(
      message: fields[0] as String?,
      jwtToken: fields[1] as String?,
      name: fields[2] as String?,
      id: fields[3] as String?,
      email: fields[4] as String?,
      status: fields[6] as bool?,
      password: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.jwtToken)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
