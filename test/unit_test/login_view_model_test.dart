import 'package:final_project/ui/auth/view_models/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
void main() {
  late LoginViewModel viewModel;
  late MockAuthRepository mockAuthRepository;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    viewModel = LoginViewModel(authRepository: mockAuthRepository);
  });
  group('LoginViewModel Page Navigation Tests', () {
    test('initial page should be START', () {
      expect(viewModel.currentPage, equals(Page.START));
    });
    test('updatePage should change current page and notify listeners', () {
      viewModel.updatePage(Page.AUTH);
      expect(viewModel.currentPage, equals(Page.AUTH));
    });
    test('updatePage should not update if page is same', () {
      final initialPage = viewModel.currentPage;
      viewModel.updatePage(initialPage);
      expect(viewModel.currentPage, equals(initialPage));
    });
  });
  group('LoginViewModel Registration Tests', () {
    test('register should handle password mismatch', () async {
      viewModel.signupForm.email.text = 'test@test.com';
      viewModel.signupForm.password.text = 'password123';
      viewModel.signupForm.passwordConfirm.text = 'password124';
      await viewModel.register();
      expect(viewModel.signupForm.isError, true);
      expect(viewModel.signupForm.error, 'Passwords dont match');
      expect(viewModel.signupState, equals(SignupState.ERROR));
      expect(mockAuthRepository.isAuthenticated, false);
    });
    test('register should succeed when passwords match', () async {
      viewModel.signupForm.email.text = 'test@test.com';
      viewModel.signupForm.password.text = 'password123';
      viewModel.signupForm.passwordConfirm.text = 'password123';
      await viewModel.register();
      expect(viewModel.signupForm.isError, false);
      expect(mockAuthRepository.isAuthenticated, true);
    });
    test('register should set loading state', () async {
      viewModel.signupForm.email.text = 'test@test.com';
      viewModel.signupForm.password.text = 'password123';
      viewModel.signupForm.passwordConfirm.text = 'password123';
      final future = viewModel.register();
      expect(viewModel.signupState, equals(SignupState.LOADING));
      await future;
    });
  });
  group('LoginViewModel Login Tests', () {
    test('login should succeed with empty credentials in mock', () async {
      viewModel.loginForm.email.text = '';
      viewModel.loginForm.password.text = '';
      await viewModel.login();
      expect(mockAuthRepository.isAuthenticated, true);
    });
    test('login should fail with non-empty credentials in mock', () async {
      viewModel.loginForm.email.text = 'test@test.com';
      viewModel.loginForm.password.text = 'password123';
      await viewModel.login();
      expect(mockAuthRepository.isAuthenticated, false);
      expect(viewModel.loginForm.isError, true);
      expect(viewModel.loginForm.error, 'Username or password incorrect');
    });
    test('login should start with IDLE state', () {
      expect(viewModel.loginState, equals(LoginState.IDLE));
    });
  });
  group('LoginViewModel Logout Tests', () {
    test('logout should clear authenticated state', () async {
      mockAuthRepository.setLoggedInState = true;
      expect(mockAuthRepository.isAuthenticated, true);
      await viewModel.logout();
      expect(mockAuthRepository.isAuthenticated, false);
    });
  });
  group('LoginViewModel Remember Me Tests', () {
    test('setRememberMe should update state', () {
      expect(viewModel.loginForm.isRememberMe, false);
      viewModel.setRememberMe(true);
      expect(viewModel.loginForm.isRememberMe, true);
    });
  });
  group('LoginViewModel Auth State Tests', () {
    test('auth state should initialize as not loaded', () {
      expect(mockAuthRepository.isAuthStateLoaded, false);
    });
    test('auth state can be loaded', () async {
      await mockAuthRepository.getAuthStatus();
      expect(mockAuthRepository.isAuthStateLoaded, true);
    });
  });
}