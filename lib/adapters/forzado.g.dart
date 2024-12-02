// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forzado.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForzadoAdapter extends TypeAdapter<Forzado> {
  @override
  final int typeId = 3;

  @override
  Forzado read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forzado(
      tagPrefijo: fields[0] as String?,
      tagCentro: fields[1] as String?,
      descripcion: fields[2] as String?,
      disciplina: fields[3] as String?,
      turno: fields[4] as String?,
      iterlockSeguridad: fields[5] as String?,
      responsable: fields[6] as String?,
      riesgoA: fields[7] as String?,
      probabilidad: fields[8] as String?,
      impacto: fields[9] as String?,
      riesgo: fields[10] as String?,
      solicitante: fields[11] as String?,
      aprobador: fields[12] as String?,
      ejecutor: fields[13] as String?,
      autorizacion: fields[14] as String?,
      tipoDeForzado: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Forzado obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.tagPrefijo)
      ..writeByte(1)
      ..write(obj.tagCentro)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.disciplina)
      ..writeByte(4)
      ..write(obj.turno)
      ..writeByte(5)
      ..write(obj.iterlockSeguridad)
      ..writeByte(6)
      ..write(obj.responsable)
      ..writeByte(7)
      ..write(obj.riesgoA)
      ..writeByte(8)
      ..write(obj.probabilidad)
      ..writeByte(9)
      ..write(obj.impacto)
      ..writeByte(10)
      ..write(obj.riesgo)
      ..writeByte(11)
      ..write(obj.solicitante)
      ..writeByte(12)
      ..write(obj.aprobador)
      ..writeByte(13)
      ..write(obj.ejecutor)
      ..writeByte(14)
      ..write(obj.autorizacion)
      ..writeByte(15)
      ..write(obj.tipoDeForzado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForzadoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
