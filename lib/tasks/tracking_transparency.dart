import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';

import '../widgets/pop_up.dart';

class TrackingTransparency {
  /// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin(BuildContext context) async {
    /// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      /// If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        /// Show a custom explainer dialog before the system dialog
        if (await showCustomTrackingDialog(context)) {
          /// Wait for dialog popping animation
          await Future.delayed(const Duration(milliseconds: 200));

          /// Request system's tracking authorization dialog
          await AppTrackingTransparency.requestTrackingAuthorization();
        }
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return PopUp(
              title: 'Something went wrong!',
              content: 'App Tracking Transparency\n$e',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    }
    // final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    // print("UUID: $uuid");
  }

  Future<bool> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 24.0,
          buttonPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
            side: BorderSide(color: Colors.white60, width: 4),
          ),
          title: const Text(
            'Dear user',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              // fontFamily: kLetterType1,
            ),
          ),
          content: const Text(
            'We keep this app free by showing some ads.\n'
            'Tracking allow us to show you ads that match your interests. '
            'The number of ads you see will not change.\n\n'
            'You can change your choice anytime in the app settings.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          actions: [
            // TextButton(
            //   onPressed: () => Navigator.pop(context, false),
            //   child: const Text("Decide later"),
            // ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Continue'),
            ),
          ],
        ),
      ) ??
      true;
}
