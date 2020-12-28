import 'dart:async';
import 'dart:convert';
import 'package:authentication_flutter_bloc/Misc/Constants/Validators.dart';
import 'package:authentication_flutter_bloc/ProgressDialog/ProgressDialog.dart';
import 'package:authentication_flutter_bloc/Services/AuthService.dart';
import 'file:///C:/Users/jaysh/FlutterProjects/authentication_flutter_bloc/lib/Misc/ToastMessage/ToastMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBLoC with Validators {
  final _registerName = BehaviorSubject<String>();
  final _registerEmail = BehaviorSubject<String>();
  final _registerSchool = BehaviorSubject<String>();
  final _registerPassword = BehaviorSubject<String>();
  final _registerConfirmPassword = BehaviorSubject<String>();

  //Getters  //This will listen to stream input
  Stream<String> get registerName =>
      _registerName.stream.transform(nameValidator);
  Stream<String> get registerEmail =>
      _registerEmail.stream.transform(emailValidator);
  Stream<String> get registerSchool =>
      _registerSchool.stream.transform(schoolValidator);
  Stream<String> get registerPassword =>
      _registerPassword.stream.transform(passwordValidator);
  Stream<String> get registerConfirmPassword =>
      _registerConfirmPassword.stream.transform(passwordValidator);

  Stream<bool> get isValid => Rx.combineLatest5(
        registerName,
        registerEmail,
        registerSchool,
        registerPassword,
        registerConfirmPassword,
        (a, b, c, d, e) => true,
      );

  /*Stream<bool> get isPasswordMatched => Rx.combineLatest2(
        registerPassword,
        registerConfirmPassword,
        (a, b) {
          if (a != b) {
            return false;
          } else {
            return true;
          }
        },
      );*/

  //Submit
  /*void submit() {
    print(_registerName.value);
    print(_registerEmail.value);
    print(_registerSchool.value);
    print(_registerPassword.value);
    print(_registerConfirmPassword.value);
  }*/

  var authInfo;
  //login
  dynamic register(BuildContext context) async {
    ProgressDialogBox()
        .showProgressDialog(context, "Registering... Please Wait...");
    authInfo = AuthService();

    final response = await authInfo.register(
      _registerEmail.value,
      _registerPassword.value,
      _registerName.value,
      _registerSchool.value,
    );
    final data = jsonDecode(response) as Map<String, dynamic>;

    if (data["code"] == "failed") {
      print(data["message"]);
      ProgressDialogBox().dismissProgressDialog(context);
      ToastMessage().showToastMessage(data["message"]);
    }
    if (data["code"] == "success") {
      ProgressDialogBox().dismissProgressDialog(context);
      ToastMessage().showToastMessage(data["message"]);
      //This will take you to your home page
      //Navigator.pushNamed(context, '/home');
      return data;
    }
  }

  //Setters //This will output to stream
  Function(String) get changeRegisterName => _registerName.sink.add;
  Function(String) get changeRegisterEmail => _registerEmail.sink.add;
  Function(String) get changeRegisterSchool => _registerSchool.sink.add;
  Function(String) get changeRegisterPassword => _registerPassword.sink.add;
  Function(String) get changeRegisterConfirmPassword =>
      _registerConfirmPassword.sink.add;

  void dispose() {
    _registerName.close();
    _registerEmail.close();
    _registerSchool.close();
    _registerPassword.close();
    _registerConfirmPassword.close();
  }
}
