import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextField extends StatelessWidget {
  const RichTextField({
    Key key,
    @required this.text1,
    @required this.text2,
    @required this.tapGestureRecognizer,
  }) : super(key: key);

  final String text1;
  final String text2;
  final TapGestureRecognizer tapGestureRecognizer;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          WidgetSpan(
            child: SizedBox(
              width: 5,
            ),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            recognizer: tapGestureRecognizer,
          ),
        ],
      ),
    );
  }
}
