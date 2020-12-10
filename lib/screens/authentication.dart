import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:mathniac_plus/screens/upload_screen.dart';

class Authentication extends StatelessWidget {
  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print("== Sign In Anonymously ==");
    } catch (e) {
      print('======= ERROR =======');
      print(e); // TODO: show dialog with error
      print('======= ERROR =======');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            _signInAnonymously();
            print("== Anonymous User: $user ==");
            return UploadScreen();
          }
          print("== == User: $user == ==");
          return UploadScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
