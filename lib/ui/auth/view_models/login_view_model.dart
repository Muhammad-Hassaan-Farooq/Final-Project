import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';

enum page { START, AUTH }

class LoginFormState {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isRememberMe = false;
}

class SignupFormState {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,
        _loginForm = LoginFormState(),
        _signupForm = SignupFormState();

  final LoginFormState _loginForm;
  LoginFormState get loginForm => _loginForm;
  final SignupFormState _signupForm;
  SignupFormState get signupForm => _signupForm;
  final AuthRepository _authRepository;
  page _currentPage = page.START;

  page get currentPage => _currentPage;

  void updatePage(page newPage) {
    if (_currentPage != newPage) {
      _currentPage = newPage;
      notifyListeners();
    }
  }

  Future<void> login() async {
    await _authRepository.login();
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }

  void setRememberMe(bool value) {
    _loginForm.isRememberMe = value;
    notifyListeners();
  }
}
