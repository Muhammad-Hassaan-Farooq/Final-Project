import 'package:flutter/cupertino.dart';

abstract class AuthRepository extends ChangeNotifier{
  bool get isAuthenticated;
  bool get isAuthStateLoaded;

  Future<void> login();
  Future<void> logout();
  Future<void> getAuthStatus();
}