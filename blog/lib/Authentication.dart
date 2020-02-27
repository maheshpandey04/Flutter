import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
abstract class AuthImplementaion {
  Future<String> SignIn(String _email, String _password);
  Future<String> SignUp(String _email, String _password);
  Future<String> getCurrentUser();
  Future<void>signOut();

}
class Auth implements AuthImplementaion {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> SignIn(String _email, String _password) async{
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: _email, password: _password)).user;
    return user.uid;
  }
  Future<String> SignUp(String _email, String _password) async{
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: _email, password: _password)).user;
    return user.uid;
  }
  Future<String> getCurrentUser()async{
    FirebaseUser user=await _firebaseAuth.currentUser();
    return user.uid;
  }
  Future<void>signOut() async
  {
    _firebaseAuth.signOut();
}
}