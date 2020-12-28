import 'package:authentication_flutter_bloc/BLoC/LoginBLoC.dart';
import 'package:authentication_flutter_bloc/Misc/Constants/Constants.dart';
import 'package:authentication_flutter_bloc/Screens/HomePage.dart';
import 'package:authentication_flutter_bloc/Screens/Register_Screen.dart';
import 'package:authentication_flutter_bloc/Widgets/RichTextField.dart';
import 'package:authentication_flutter_bloc/Widgets/StreamBuilderGenericButton.dart';
import 'package:authentication_flutter_bloc/Widgets/StreamBuilderTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setValue();
  }

  void setValue() async {
    final prefs = await SharedPreferences.getInstance();
    String dataSet = prefs.get("Email");
    if (dataSet != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
        if (rememberMe) {
          print(rememberMe);
        } else {
          print("false");
        }
      });

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBLoc>(context, listen: false);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            alignment: Alignment.center,
            //color: Color(0xffdee2e6),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderTextField(
                    obscureText: false,
                    loginBLoc: bloc,
                    hintText: "Enter Email",
                    labelText: "Email",
                    blocStreamText: bloc.loginEmail,
                    blocOnChangeText: bloc.changeLoginEmail,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderTextField(
                    obscureText: true,
                    loginBLoc: bloc,
                    hintText: "Enter Password",
                    labelText: "Password",
                    blocStreamText: bloc.loginPassword,
                    blocOnChangeText: bloc.changeLoginPassword,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          StreamBuilder<bool>(
                              stream: bloc.checkBoxState,
                              builder: (context, snapshot) {
                                return Checkbox(
                                    value: rememberMe,
                                    onChanged: _onRememberMeChanged);
                              }),
                          Text("Remember Me"),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Forgot Password");
                        },
                        child: Text("Forgot Password?"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderGenericButton(
                    loginBLoc: bloc,
                    blocValidation: bloc.isValid,
                    text: "Login",
                    blocDataSubmit: bloc.login,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichTextField(
                    text1: "Need an account?",
                    text2: "Register Here",
                    tapGestureRecognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
