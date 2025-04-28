import 'package:forzado/models/model_user_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  factory PreferencesHelper() => _instance;

  PreferencesHelper._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUser(ApiResponseDetailUser user) async {
    print('úser');
    print(user.toJson());
    int role = int.parse(
        user.roles.keys.reduce((a, b) => int.parse(a) > int.parse(b) ? a : b));
    await _prefs.setBool('logged', true);
    await _prefs.setInt('id', user.id);
    await _prefs.setString('username', user.name);
    await _prefs.setString('area', user.area);
    await _prefs.setInt('rol', role);
    await _prefs.setInt('flag', user.flagNuevoIngreso);
    await _prefs.setString('grupo', user.grupo??'');
    await _prefs.setInt('grupoId', user.grupoId??10);
  }

  ApiResponseDetailUser? getUser() {
    final int? id = _prefs.getInt('id');
    final String? username = _prefs.getString('username');
    final String? area = _prefs.getString('area');
    final int? role = _prefs.getInt('rol');
    final int? flagNuevoIngreso = _prefs.getInt('flag');

    // Si alguno de los valores esenciales es nulo, devuelve null
    if (id == null ||
        username == null ||
        area == null ||
        role == null ||
        flagNuevoIngreso == null) {
      return null;
    }

    return ApiResponseDetailUser(
      id: id,
      name: username,
      area: area,
      roles: {role.toString(): 'role'},
      flagNuevoIngreso: flagNuevoIngreso,
      jwt: '0',
    );
  }

  Future<void> clear() async {
    await _prefs.clear();
    await _prefs.setBool('aceptOm', true);
  }
}
