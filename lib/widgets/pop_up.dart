import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onPressed;

  const PopUp({
    this.title,
    this.content,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 24.0,
      buttonPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
        side: BorderSide(color: Colors.white60, width: 4),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          // fontFamily: kLetterType1,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text(
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
