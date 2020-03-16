import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference with ChangeNotifier {
  SharedPreferences sharedPreferences;
  final String key;

  Preference({@required this.key}) {
    _initializePreferences();
  }

  _initializePreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  setStringValue({@required String value}) {
    sharedPreferences.setString(key, value);
    //notifyListeners();
  }

  String getStringValue() {
    String value =
        sharedPreferences?.getString(key) ?? DateTime.now().toString();
    //notifyListeners();
    return value;
  }
}
