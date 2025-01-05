import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthRepository extends AuthRepository{

  bool _isLoggedIn = false;
  bool _isAuthStateLoaded = false;
  final AuthService _authService = AuthService();

  @override
  Future<void> getAuthStatus() async{
    try{
      User? user = _authService.currentUser;
      print(user);
      if(user == null){
        _isLoggedIn = false;
        _isAuthStateLoaded = true;
      }
      else{
        _isLoggedIn = true;
        _isAuthStateLoaded = true;
      }
    }
    catch(e){

      _isLoggedIn = false;
      _isAuthStateLoaded = false;
    }
      notifyListeners();
  }

  @override
  bool get isAuthStateLoaded => _isAuthStateLoaded;

  @override
  bool get isAuthenticated => _isLoggedIn;

  @override
  Future<void> login(String email, String password) async{
    try {
      final user = await _authService.signInWithEmail(email, password);
      _isLoggedIn = user != null;
    }
    catch(e){
      _isLoggedIn = false;
    }
    notifyListeners();
  }
  @override
  Future<void> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      _isLoggedIn =  user != null;
    } catch (e) {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  @override
  Future<void> logout() async{
    await _authService.signOut();
    _isLoggedIn = false;
    notifyListeners();
  }

  @override
  Future<void> signUp(String email, String password) async{

    try {
      final user = await _authService.signUpWithEmail(email, password);
      _isLoggedIn= user != null;
    } catch (e) {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

}