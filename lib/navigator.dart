import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_sample/firebase_real_time_database.dart';
import 'package:firebase_sample/firestore_sample.dart';
import 'google_sign_in_sample.dart';

goToRealTimeDatabase(BuildContext context, FirebaseApp app) {
  _pushWithFade(context, MyHomePage(app));
}

goToFireStore(BuildContext context) {
  _pushWithFade(context, FireStoreSample());
}

goToSignIn(BuildContext context) {
  _pushWithFade(context, GoogleSignInSample());
}

_pushWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
      PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
            return widget;
        }
      )
  );
}