import 'package:flutter/material.dart';
import 'api.dart';

import 'dart:async';

import 'dart:ui' show ImageFilter;

class GoogleSignInSample extends StatelessWidget {
  Future<bool> _loginUser() async {
    final api = await FirebaseAPI.signInWithGoogle();
    if (api != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Text("login"),
                      FlatButton(onPressed: () async {
                        bool signedIn = await _loginUser();

                        if (signedIn) {
                          print("Success");
                        } else {
                          print("fail");
                        }
                      }, child: Text("Sign in"))
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
}
