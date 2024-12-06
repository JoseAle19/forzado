
enum Roles {
  Solicitante,
  Aprobador,
  Ejecutor,
}

class RoleMapper {
  // Mapeo de los IDs a los roles
  static Roles fromId(int id) {
    switch (id) {
      case 2:
      case 5:
        return Roles.Solicitante;
      case 3:
      case 6:
        return Roles.Aprobador;
      case 4:
      case 7:
        return Roles.Ejecutor;
      default:
        throw ArgumentError('ID no válido para un rol');
    }
  }
}
