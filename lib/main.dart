import 'package:firebase_sample/firebase_selection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:io' show Platform;

void main() async {

  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:583185148223:ios:4ce846793000045e',
      gcmSenderID: '83185148223',
      databaseURL: 'https://databasetest-3b939.firebaseio.com',
    )
        : const FirebaseOptions(
      googleAppID: '1:583185148223:android:4ce846793000045e',
      apiKey: 'AIzaSyBOxdkjGoCS9mXJJ4mwc8IBDC2w0SANQZ8',
      databaseURL: 'https://databasetest-3b939.firebaseio.com',
    ),
  );

  runApp(MyApp(app));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final FirebaseApp app;

  MyApp(this.app);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Demo',
      theme: new ThemeData.dark(),
      home: MainPage(app),
    );
  }
}


