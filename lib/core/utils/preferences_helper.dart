
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



Future<void> setUser(ApiResponseDetailUser user)async{
  await _prefs.setBool('logged', true);
  await _prefs.setInt('id', user.id);
  await _prefs.setString('username', user.name);
  await _prefs.setString('area', user.area);
  await _prefs.setInt('rol', user.role);
  await _prefs.setInt('flag', user.flagNuevoIngreso);
 }

ApiResponseDetailUser? getUser() => ApiResponseDetailUser(id: _prefs.getInt('id')!, name: _prefs.getString('username')!, area: _prefs.getString('area')!, role: _prefs.getInt('rol')!, flagNuevoIngreso: _prefs.getInt('flag')!, jwt: '0');

Future<void> clear() async {
    await _prefs.clear();
    await _prefs.setBool('aceptOm', true);

  }
}