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


  @override
  Future<void> login() async{
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn =  true;
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
}