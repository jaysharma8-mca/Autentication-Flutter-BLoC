import 'package:authentication_flutter_bloc/BLoC/LoginBLoC.dart';
import 'package:authentication_flutter_bloc/BLoC/RegisterBLoC.dart';
import 'package:authentication_flutter_bloc/Screens/Register_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Misc/SharedPreferences/SharedPreferences.dart';
import 'Screens/HomePage.dart';
import 'Screens/Login_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBLoc>(
          create: (context) => LoginBLoc(),
        ),
        Provider<RegisterBLoC>(
          create: (context) => RegisterBLoC(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLoC Authentication',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: LoginScreen(),
        routes: {
          '/home': (_) => HomePage(),
          '/login': (_) => new LoginScreen(),
          '/signup': (_) => new RegisterScreen(),
          //'/forgot_password': (_) => new ForgotPassword(),
        },
      ),
    );
  }
}
