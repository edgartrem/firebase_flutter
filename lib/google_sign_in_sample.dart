import 'package:flutter/material.dart';
import 'api.dart';

import 'dart:async';

import 'dart:ui' show ImageFilter;

class GoogleSignInSample extends StatelessWidget {
  Future<FirebaseAPI> _loginUser() async {
    final api = await FirebaseAPI.signInWithGoogle();
    if (api != null) {
      return api;
    } else {
      return null;
    }

  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign in"),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(width: 250.0, height: 250.0),
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: 250.0,
                  height: 250.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () async {
                            FirebaseAPI signedIn = await _loginUser();

                            if (signedIn != null) {
                              showInSnackBar("Signed in as ${signedIn.user.displayName}");
                            } else {
                              print("fail");
                            }
                          },
                          child: Text("Sign in"))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(value),
      action: SnackBarAction(label: 'Log out', onPressed: () {
        FirebaseAPI.signOut();
      }),
      duration: Duration(days: 1),
    ));
  }
}
