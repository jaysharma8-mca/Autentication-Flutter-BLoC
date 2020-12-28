import 'package:authentication_flutter_bloc/BLoC/LoginBLoC.dart';
import 'package:authentication_flutter_bloc/BLoC/RegisterBLoC.dart';
import 'package:flutter/material.dart';

class StreamBuilderTextField extends StatefulWidget {
  const StreamBuilderTextField({
    Key key,
    this.loginBLoc,
    this.registerBLoC,
    this.obscureText,
    @required this.hintText,
    @required this.labelText,
    @required this.blocStreamText,
    @required this.blocOnChangeText,
    this.iconButton,
  }) : super(key: key);

  final LoginBLoc loginBLoc;
  final RegisterBLoC registerBLoC;
  final bool obscureText;
  final String hintText;
  final String labelText;
  final Stream blocStreamText;
  final Function blocOnChangeText;
  final IconButton iconButton;

  @override
  _StreamBuilderTextFieldState createState() => _StreamBuilderTextFieldState();
}

class _StreamBuilderTextFieldState extends State<StreamBuilderTextField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.blocStreamText,
      builder: (context, snapshot) {
        return TextField(
          obscureText: widget.obscureText,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorText: snapshot.error,
            hintText: widget.hintText,
            labelText: widget.labelText,
            labelStyle: TextStyle(color: Colors.grey[900]),
            contentPadding:
                EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey[900]),
            ),
            suffixIcon: widget.iconButton,
          ),
          onChanged: widget.blocOnChangeText,
        );
      },
    );
  }
}
