import 'package:flutter/cupertino.dart';

abstract class AuthRepository extends ChangeNotifier{
  bool get isAuthenticated;
  bool get isAuthStateLoaded;

  Future<void> login(String email, String password);
  Future<void> logout();
  Future<void> getAuthStatus();
  Future<void> signInWithGoogle();
  Future<void> signUp(String email, String password);

}