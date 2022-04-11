import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  final preference = SharedPreferences.getInstance();

  Future<List<String>> getListString(String key) async {
    final pref = await preference;
    final value = pref.getStringList(key) ?? ['0'];
    return value;
  }

  Future<void> setListString(String key, List<String> value) async {
    final pref = await preference;
    await pref.setStringList(key, value);
  }
}
