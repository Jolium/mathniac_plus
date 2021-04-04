import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mathniac_plus/widgets/pop_up.dart';

import 'upload_screen.dart';

class Authentication extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print("== Sign In Anonymously ==");
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return PopUp(
              title: 'Something went wrong!',
              content:
              e.toString(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      // print('======= ERROR =======');
      // print(e); // TODO: show dialog with error
      // print('======= ERROR =======');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            _signInAnonymously(context);
            print("== Anonymous User: $user ==");
            return UploadScreen();
          }
          print("== == User: $user == ==");
          return UploadScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
