import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:async';

class FirebaseAPI {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _signIn = GoogleSignIn();

  FirebaseUser user;

  FirebaseAPI(FirebaseUser user) {
    this.user = user;
  }

  static signOut() async {
    await _auth.signOut();
  }

  static Future<FirebaseAPI> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _signIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final FirebaseUser user = await _auth.signInWithGoogle(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    assert(user.email != null);
    assert(user.displayName != null);

    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return FirebaseAPI(user);
  }


}