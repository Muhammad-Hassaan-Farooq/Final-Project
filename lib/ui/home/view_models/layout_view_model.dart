import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';


class LayoutViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  int _index;

  int get currentIndex => _index;



  LayoutViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,_index = 0;

  Future<void> logout() async {
    await _authRepository.logout();
  }

  void onTabTapped(int index) {
   _index = index;
   notifyListeners();
  }



}
