import 'dart:async';
import 'package:authentication_flutter_bloc/Misc/Constants/Validators.dart';
import 'package:authentication_flutter_bloc/Misc/SharedPreferences/SharedPreferences.dart';
import 'package:authentication_flutter_bloc/Misc/ToastMessage/ToastMessage.dart';
import 'package:authentication_flutter_bloc/ProgressDialog/ProgressDialog.dart';
import 'package:authentication_flutter_bloc/Screens/HomePage.dart';
import 'package:authentication_flutter_bloc/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class LoginBLoc with Validators {
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();
  final _checkBoxState = new BehaviorSubject<bool>();

  //Getters  //This will listen to stream input
  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(loginPasswordValidator);
  Stream<bool> get checkBoxState => _checkBoxState.stream;
  Stream<bool> get isValid =>
      Rx.combineLatest2(loginEmail, loginPassword, (a, b) => true);

  //Setters //This will output to stream
  Function(String) get changeLoginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;
  Function(String) get addError => _errorMessage.sink.add;
  Function(bool) get changeCheckBoxValue => _checkBoxState.sink.add;

  var authInfo;
  //login
  dynamic login(BuildContext context) async {
    ProgressDialogBox()
        .showProgressDialog(context, "Logging In... Please Wait...");
    authInfo = AuthService();

    final response =
        await authInfo.login(_loginEmail.value, _loginPassword.value);
    final data = jsonDecode(response) as Map<String, dynamic>;

    if (data["code"] == "failed") {
      print(data["message"]);
      ProgressDialogBox().dismissProgressDialog(context);
      ToastMessage().showToastMessage(data["message"]);
      print(_checkBoxState.value);
    }
    if (data["code"] == "success") {
      ProgressDialogBox().dismissProgressDialog(context);
      ToastMessage().showToastMessage(data["message"]);
      print(data["user"]["id"]);
      print(data["user"]["email"]);
      print(data["user"]["name"]);
      SharedPreference()
          .saveInLocalMemory(data["user"]["email"], _loginPassword.value);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      return data;
    }
  }

  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
    _errorMessage.close();
    _checkBoxState.close();
  }
}
