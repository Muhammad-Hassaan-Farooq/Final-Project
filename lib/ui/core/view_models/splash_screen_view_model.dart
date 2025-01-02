import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';



class SplashScreenViewModel extends ChangeNotifier{
  SplashScreenViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<void> checkAuthStatus() async {
    await _authRepository.getAuthStatus();
  }
}