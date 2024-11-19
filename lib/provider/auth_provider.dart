import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireAuth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class AuthProfider extends ChangeNotifier {
  final form = GlobalKey<FormState>();

  var isLogin = true;
  var enteredName = '';
  var enteredOrigin = '';
  var enteredEmail = '';
  var enteredPassword = '';
  var enteredAge = '';
  var enteredSchool = '';
  var imageUrl = '';

  void submit(BuildContext context) async {
    final _isValid = form.currentState!.validate();

    if (!_isValid) {
      return;
    }

    form.currentState!.save();

    try {
      if (isLogin) {
        await _fireAuth.signInWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);
      } else {
        UserCredential userCredential =
            await _fireAuth.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );

        // Save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'name': enteredName,
          'origin': enteredOrigin,
          'email': enteredEmail,
          'age': enteredAge,
          'school': enteredSchool,
          'imageUrl': imageUrl, // Add image URL here
        });
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        _showSnackBar(context, _handleAuthException(e));
      } else {
        _showSnackBar(context, "Terjadi kesalahan, silakan coba lagi.");
      }
    }

    notifyListeners();
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "Email tidak terdaftar.";
      case 'wrong-password':
        return "Password salah.";
      case 'email-already-in-use':
        return "Email sudah terdaftar.";
      default:
        return "Terjadi kesalahan, silakan coba lagi.";
    }
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
