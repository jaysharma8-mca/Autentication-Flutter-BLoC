import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final baseUrl = "https://jaysharma8.000webhostapp.com";
  // ignore: non_constant_identifier_names
  static final SESSION = FlutterSession();

  Future<dynamic> register(
      String email, String password, String name, String school) async {
    try {
      var response = await http.post("$baseUrl/register.php", body: {
        "email": email,
        "password": password,
        "name": name,
        "school": school,
      });
      return response?.body;
    } finally {}
  }

  Future<dynamic> login(String email, String passwd) async {
    try {
      var response = await http.post("$baseUrl/login.php", body: {
        "email": email,
        "passwd": passwd,
        //"token": "token to be sent",
      });
      return response?.body;
    } finally {}
  }

  static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    return await SESSION.set("tokens", data);
  }

  static getToken(String token, String refreshToken) async {
    return await SESSION.get("tokens");
  }
}

class _AuthData {
  _AuthData(this.token, this.refreshToken, {this.clientId});

  String token;
  String refreshToken;
  String clientId;

  //toJson
  //required by session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data["token"] = token;
    data["refreshToken"] = refreshToken;
    data["clientId"] = clientId;
    return data;
  }
}
