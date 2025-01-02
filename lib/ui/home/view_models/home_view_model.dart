import 'package:flutter/cupertino.dart';

import '../../../data/repositories/auth/auth_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<void> logout() async{
    await _authRepository.logout();
  }
}
