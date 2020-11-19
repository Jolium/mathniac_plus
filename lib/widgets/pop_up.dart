import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  final String title;
  final String content;
  final Function onPressed;

  PopUp({this.title, this.content, @required this.onPressed});

  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 24.0,
      buttonPadding: EdgeInsets.all(16),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
        side: BorderSide(color: Colors.white60, width: 4),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          // fontFamily: kLetterType1,
        ),
      ),
      content: Text(
        widget.content,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: widget.onPressed,
          // () {
          // Navigator.of(context).pushReplacement(
          //   CustomRoute(builder: (context) => LoginPage()),
          // );
          // },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          child: Text(
            'Dismiss',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
