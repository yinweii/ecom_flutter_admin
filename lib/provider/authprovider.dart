import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  User user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // user login
  Future<void> userRegister(String email, String password, String name) async {
    setIsLoading(true);
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = authResult.user;

      _firebaseFirestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': name,
        'userCart': [],
      });

      setIsLoading(false);
    } on SocketException {
      setIsLoading(false);
      setMessage('No internet....');
    } catch (e) {
      setIsLoading(false);
      setMessage(e.message);
    }
    notifyListeners();
  }

  // user  login
  Future<void> userLogIn(String email, String password) async {
    setIsLoading(true);
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = authResult.user;

      setIsLoading(false);
    } on SocketException {
      setIsLoading(false);
      setMessage('No internet....');
    } catch (e) {
      setIsLoading(false);
      setMessage(e.message);
    }
    notifyListeners();
  }

  Future signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    print(_errorMessage);
    notifyListeners();
  }

  Stream<User> get users => _auth.authStateChanges().map((event) => event);
}
