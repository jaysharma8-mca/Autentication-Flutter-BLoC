import 'package:authentication_flutter_bloc/Misc/Constants/Constants.dart';
import 'package:authentication_flutter_bloc/Misc/SharedPreferences/SharedPreferences.dart';
import 'package:authentication_flutter_bloc/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreference().readFromLocalMemory();
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Home Page"),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            color: Colors.blueGrey,
            onPressed: () {
              SharedPreference().deleteSharedPreferencesData();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
