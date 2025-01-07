import 'auth_repository.dart';

class MockAuthRepository extends AuthRepository {
  bool _isLoggedIn = false;
  bool _isAuthStateLoaded = false;

  @override
  bool get isAuthenticated {
    return _isLoggedIn;
  }
  @override
  bool get isAuthStateLoaded{
    return _isAuthStateLoaded;
  }
  set setAuthState(bool authState){
    _isAuthStateLoaded = authState;
  }
  set setLoggedInState(bool authState){
    _isLoggedIn = authState;
  }


  @override
  Future<void> login(String email, String password) async{
    if(email =="" && password == ""){
      await Future.delayed(const Duration(milliseconds: 500));
      _isLoggedIn =  true;
    }
    else{
      await Future.delayed(const Duration(milliseconds: 500));
      _isLoggedIn =  false;
    }

    notifyListeners();
  }

  @override
  Future<void> logout() async{
    _isLoggedIn = false;
    notifyListeners();
  }

  @override
  Future<void> getAuthStatus() async{
    await Future.delayed(const Duration(microseconds: 500));
    _isAuthStateLoaded = true;
    notifyListeners();
  }

  @override
  Future<void> signInWithGoogle() async{
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn =  true;
  }

  @override
  Future<void> signUp(String email, String password) async{
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn =  true;
  }
}