import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationClient {
  FirebaseAuth auth = FirebaseAuth.instance;

  registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    User? user;

    try {
      final UserCredential userCendential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCendential.user;
      await user!.updateDisplayName(name);
      user = auth.currentUser;
    } catch (e) {
      log(e.toString());
    }

    return user;
  }

  loginUser({
    required String email,
    required String password,
  }) async {
    User? user;

    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
    } catch (e) {
      log(e.toString());
    }

    return user;
  }

  loginWithGoogle(BuildContext context) async {
    GoogleSignIn objGoogleSignIn = GoogleSignIn();
    GoogleSignInAccount? objGOogleSignInAccount =
        await objGoogleSignIn.signIn();
    if (objGOogleSignInAccount != null) {
      GoogleSignInAuthentication objGoogleSignInAuthentication =
          await objGOogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: objGoogleSignInAuthentication.accessToken,
          idToken: objGoogleSignInAuthentication.idToken);
      try {
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;
        return user;
      } on FirebaseAuthException catch (e) {
        print("No se pudo inicar");
      }
    }
  }

  logoutUser() async {
    await auth.signOut();
  }
}
