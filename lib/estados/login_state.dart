import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? _user;

  User? currentUser() => _user;

  bool isLoggedIn() => _loggedIn;

  void login(User user) {
    _loggedIn = true;
    _user = user;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
