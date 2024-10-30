import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _fireAuth = FirebaseAuth.instance;

class AuthProfider extends ChangeNotifier {
  final form = GlobalKey<FormState>();

  var isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';

  void submit(BuildContext context) async {
    final _isValid = form.currentState!.validate();

    if (!_isValid) {
      return;
    }

    form.currentState!.save();

    try {
      if (isLogin) {
        await _fireAuth.signInWithEmailAndPassword(email: enteredEmail, password: enteredPassword);
      } else {
        await _fireAuth.createUserWithEmailAndPassword(email: enteredEmail, password: enteredPassword);
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          _showSnackBar(context, "Email tidak terdaftar.");
        } else if (e.code == 'wrong-password') {
          _showSnackBar(context, "Password salah.");
        } else if (e.code == 'email-already-in-use') {
          _showSnackBar(context, "Email sudah terdaftar.");
        } else {
          _showSnackBar(context, "Terjadi kesalahan, silakan coba lagi.");
        }
      }
    }

    notifyListeners();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
