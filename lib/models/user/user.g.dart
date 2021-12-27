// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<String>(),
      (fields[4] as List).cast<String>(),
      (fields[5] as List).cast<String>(),
      (fields[6] as List).cast<String>(),
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._mail)
      ..writeByte(2)
      ..write(obj._photoURL)
      ..writeByte(3)
      ..write(obj._pinnedPosts)
      ..writeByte(4)
      ..write(obj._events)
      ..writeByte(5)
      ..write(obj._clubs)
      ..writeByte(6)
      ..write(obj._interests)
      ..writeByte(7)
      ..write(obj._name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
