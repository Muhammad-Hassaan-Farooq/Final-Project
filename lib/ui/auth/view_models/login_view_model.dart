import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';

enum Page { START, AUTH }
enum SignupState {IDLE, LOADING, ERROR}
enum LoginState {IDLE,LOADING, ERROR}

class LoginFormState {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isRememberMe = false;
  String error = "";
  bool isError = false;
}

class SignupFormState {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  String error = "";
  bool isError = false;
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository,
        _loginForm = LoginFormState(),
        _signupForm = SignupFormState(),
        _signupState = SignupState.IDLE,
        _loginState = LoginState.IDLE;

  SignupState _signupState;
  LoginState _loginState;

  LoginState get loginState =>_loginState;
  SignupState get signupState => _signupState;

  final LoginFormState _loginForm;
  LoginFormState get loginForm => _loginForm;
  final SignupFormState _signupForm;
  SignupFormState get signupForm => _signupForm;
  final AuthRepository _authRepository;
  Page _currentPage = Page.START;
  

  Page get currentPage => _currentPage;

  void updatePage(Page newPage) {
    if (_currentPage != newPage) {
      _currentPage = newPage;
      notifyListeners();
    }
  }

  Future<void> register() async {
    final String email = _signupForm.email.text;
    final String password = _signupForm.password.text;
    final String confirmPassword = _signupForm.passwordConfirm.text;

    try{
      _signupState = SignupState.LOADING;
      if(password != confirmPassword){
        signupForm.error= "Passwords dont match";
        _signupState = SignupState.ERROR;
        signupForm.isError = true;
        notifyListeners();
      }
      else{
        await _authRepository.signUp(email, password);
        signupForm.isError = false;
      }

    }
    catch(e){
      _signupState = SignupState.ERROR;
    }

  }

  Future<void> login() async {
    try{
      loginForm.isError = true;
      await _authRepository.login(
          _loginForm.email.text, _loginForm.password.text);

      if(!_authRepository.isAuthenticated){
        loginForm.isError = true;
        loginForm.error = "Username or password incorrect";
      }
    }
    catch(e){
      loginForm.isError = true;
      loginForm.error = "Username or password incorrect";
    }
    notifyListeners();

  }

  Future<void> signInWithGoogle() async{
    try{
      _authRepository.signInWithGoogle();
    }
    catch(e){

    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }

  void setRememberMe(bool value) {
    _loginForm.isRememberMe = value;
    notifyListeners();
  }
}
