import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<void> saveInLocalMemory(String email, String password) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("Email", email);
    pref.setString("Password", password);
  }

  Future<void> readFromLocalMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("Email");
    print(email);
  }

  Future<void> deleteSharedPreferencesData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.clear();
    //Set<String> keys = sharedPreference.getKeys();
    //keys.remove("Email");
    //keys.remove("Password");
  }
}
