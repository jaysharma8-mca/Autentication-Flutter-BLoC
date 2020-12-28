import 'package:authentication_flutter_bloc/BLoC/RegisterBLoC.dart';
import 'package:authentication_flutter_bloc/Misc/Constants/Constants.dart';
import 'package:authentication_flutter_bloc/Screens/Login_Screen.dart';
import 'package:authentication_flutter_bloc/Widgets/RichTextField.dart';
import 'package:authentication_flutter_bloc/Widgets/StreamBuilderGenericButton.dart';
import 'package:authentication_flutter_bloc/Widgets/StreamBuilderTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBLoC>(context, listen: false);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderTextField(
                    obscureText: false,
                    registerBLoC: bloc,
                    hintText: "Enter Name",
                    labelText: "Name",
                    blocStreamText: bloc.registerName,
                    blocOnChangeText: bloc.changeRegisterName,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderTextField(
                    obscureText: false,
                    registerBLoC: bloc,
                    hintText: "Enter Email",
                    labelText: "Email",
                    blocStreamText: bloc.registerEmail,
                    blocOnChangeText: bloc.changeRegisterEmail,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderTextField(
                    obscureText: false,
                    registerBLoC: bloc,
                    hintText: "Enter School Name",
                    labelText: "School Name",
                    blocStreamText: bloc.registerSchool,
                    blocOnChangeText: bloc.changeRegisterSchool,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderTextField(
                    obscureText: true,
                    registerBLoC: bloc,
                    hintText: "Enter Password",
                    labelText: "Password",
                    blocStreamText: bloc.registerPassword,
                    blocOnChangeText: bloc.changeRegisterPassword,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder<String>(
                    stream: bloc.registerConfirmPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        obscureText: isVisible,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: snapshot.error,
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.grey[900]),
                          contentPadding: EdgeInsets.only(
                              left: 25, right: 25, top: 20, bottom: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.grey[900]),
                          ),
                          suffixIcon: IconButton(
                            icon: isVisible
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                            onPressed: () {
                              print("onPressed");
                              setState(() {
                                print("onPressed Set State");
                                isVisible = !isVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: bloc.changeRegisterConfirmPassword,
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilderGenericButton(
                    registerBLoC: bloc,
                    blocValidation: bloc.isValid,
                    text: "Register",
                    blocDataSubmit: bloc.register,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichTextField(
                    text1: "Already have an account?",
                    text2: "Login here",
                    tapGestureRecognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
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
