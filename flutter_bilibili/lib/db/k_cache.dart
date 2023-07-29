
import 'package:shared_preferences/shared_preferences.dart';

class KCache {

  SharedPreferences? _pres;

  KCache._internal() {
    init();
  }

  void init() async {
    print("_pres是否为空？${this._pres}");
    _pres ??= await SharedPreferences.getInstance();
  }

  static KCache? _instance;
  static KCache getInstance() {
    return _instance ??= KCache._internal();
  }

  static Future<KCache?> preInit() async{
    if (_instance == null) {
      var tempPres = await SharedPreferences.getInstance();
      _instance = KCache.pre(tempPres);
    }
    return _instance;
  }
  KCache.pre(SharedPreferences pres) {
    _pres = pres;
  }

  setBool(String key, bool value) {
    _pres?.setBool(key, value);
  }
  setInt(String key, int value) {
    _pres?.setInt(key, value);
  }
  setDouble(String key, double value) {
    _pres?.setDouble(key, value);
  }

  setString(String key, String value) {
    _pres?.setString(key, value);
  }

  setStringList(String key, List<String> value) {
    _pres?.setStringList(key, value);
  }

  Object? get(String key) {
    return _pres?.get(key);
  }
}