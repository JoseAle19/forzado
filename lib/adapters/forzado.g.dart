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
      tagPrefijoId: fields[0] as int?,
      tagPrefijoDescripcion: fields[1] as String?,
      tagCentroId: fields[2] as int?,
      tagCentroDescripcion: fields[3] as String?,
      tagDisciplinaId: fields[4] as int?,
      tagDisciplinaDescripcion: fields[5] as String?,
      probabilityId: fields[6] as int?,
      probabilityDescripcion: fields[7] as String?,
      impactId: fields[8] as int?,
      impactDescripcion: fields[9] as String?,
      circuitosId: fields[10] as int?,
      circuitosDescripcion: fields[11] as String?,
      riskAId: fields[12] as int?,
      riskADescripcion: fields[13] as String?,
      riskId: fields[14] as int?,
      riskDescripcion: fields[15] as String?,
      grupoId: fields[16] as int?,
      grupoDescripcion: fields[17] as String?,
      applicantId: fields[18] as int?,
      applicantDescripcion: fields[19] as String?,
      responsibilityId: fields[20] as int?,
      responsibilityDescripcion: fields[21] as String?,
      approverId: fields[22] as int?,
      approverDescripcion: fields[23] as String?,
      description: fields[24] as String,
      subfijo: fields[25] as String,
      interlock: fields[26] as int?,
      idUsuario: fields[27] as int?,
      dateRequest: fields[28] as String?,
      shiftDescription: fields[31] as String?,
      shiftId: fields[30] as int?,
      usuarioDescription: fields[29] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Forzado obj) {
    writer
      ..writeByte(32)
      ..writeByte(0)
      ..write(obj.tagPrefijoId)
      ..writeByte(1)
      ..write(obj.tagPrefijoDescripcion)
      ..writeByte(2)
      ..write(obj.tagCentroId)
      ..writeByte(3)
      ..write(obj.tagCentroDescripcion)
      ..writeByte(4)
      ..write(obj.tagDisciplinaId)
      ..writeByte(5)
      ..write(obj.tagDisciplinaDescripcion)
      ..writeByte(6)
      ..write(obj.probabilityId)
      ..writeByte(7)
      ..write(obj.probabilityDescripcion)
      ..writeByte(8)
      ..write(obj.impactId)
      ..writeByte(9)
      ..write(obj.impactDescripcion)
      ..writeByte(10)
      ..write(obj.circuitosId)
      ..writeByte(11)
      ..write(obj.circuitosDescripcion)
      ..writeByte(12)
      ..write(obj.riskAId)
      ..writeByte(13)
      ..write(obj.riskADescripcion)
      ..writeByte(14)
      ..write(obj.riskId)
      ..writeByte(15)
      ..write(obj.riskDescripcion)
      ..writeByte(16)
      ..write(obj.grupoId)
      ..writeByte(17)
      ..write(obj.grupoDescripcion)
      ..writeByte(18)
      ..write(obj.applicantId)
      ..writeByte(19)
      ..write(obj.applicantDescripcion)
      ..writeByte(20)
      ..write(obj.responsibilityId)
      ..writeByte(21)
      ..write(obj.responsibilityDescripcion)
      ..writeByte(22)
      ..write(obj.approverId)
      ..writeByte(23)
      ..write(obj.approverDescripcion)
      ..writeByte(24)
      ..write(obj.description)
      ..writeByte(25)
      ..write(obj.subfijo)
      ..writeByte(26)
      ..write(obj.interlock)
      ..writeByte(27)
      ..write(obj.idUsuario)
      ..writeByte(28)
      ..write(obj.dateRequest)
      ..writeByte(29)
      ..write(obj.usuarioDescription)
      ..writeByte(30)
      ..write(obj.shiftId)
      ..writeByte(31)
      ..write(obj.shiftDescription);
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
