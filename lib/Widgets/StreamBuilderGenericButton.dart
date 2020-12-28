import 'package:authentication_flutter_bloc/BLoC/LoginBLoC.dart';
import 'package:authentication_flutter_bloc/BLoC/RegisterBLoC.dart';
import 'package:flutter/material.dart';

class StreamBuilderGenericButton extends StatelessWidget {
  const StreamBuilderGenericButton({
    Key key,
    this.loginBLoc,
    this.registerBLoC,
    this.text,
    this.blocValidation,
    this.blocDataSubmit,
  }) : super(key: key);

  final LoginBLoc loginBLoc;
  final RegisterBLoC registerBLoC;
  final String text;
  final Stream blocValidation;
  final Function blocDataSubmit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: blocValidation,
      builder: (context, snapshot) => RaisedButton(
        onPressed: snapshot.hasError || !snapshot.hasData
            ? null
            : () {
                FocusScope.of(context).unfocus();
                return blocDataSubmit(context);
              },
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.black),
        ),
        splashColor: Colors.orange,
        animationDuration: Duration(seconds: 5),
        padding: EdgeInsets.only(left: 60, right: 60, top: 13, bottom: 13),
        color: snapshot.hasError ? Colors.grey : Colors.greenAccent,
        elevation: 5,
        child: Text(
          text,
          style: TextStyle(
            color: snapshot.hasError ? Colors.white : Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
