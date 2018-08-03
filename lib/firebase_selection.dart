import 'package:flutter/material.dart';
import 'navigator.dart';

import 'package:firebase_core/firebase_core.dart';


class MainPage extends StatelessWidget {
  final FirebaseApp app;

  MainPage(this.app);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.assignment_ind),
              iconSize: 50.0,
              onPressed: () {
                goToSignIn(context);
              }),
          Text("Signing In"),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          IconButton(
              icon: Icon(Icons.storage), iconSize: 50.0, onPressed: () {
                goToRealTimeDatabase(context, app);
          }),
          Text("Real time Database"),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          IconButton(icon: Icon(Icons.store), iconSize: 50.0, onPressed: () {
            goToFireStore(context);
          }),
          Text("Firestore database"),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    ));
  }
}
