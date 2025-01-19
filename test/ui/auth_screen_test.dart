import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/ui/auth/bloc/auth_bloc.dart';
import 'package:final_project/ui/auth/view_models/login_view_model.dart';
import 'package:final_project/ui/auth/widgets/login_screen.dart';
import 'package:final_project/ui/core/theme.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main(){
  testWidgets("Auth screen golden test",(WidgetTester tester) async{
    await loadAppFonts();
    tester.view.physicalSize = Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: LoginScreen(authBloc: AuthBloc(authRepository: MockAuthRepository()),),
        )
    );

    await expectLater(find.byType(LoginScreen),
        matchesGoldenFile('login_sc.png'));
  });

  testWidgets("Login Screen golden test", (WidgetTester tester) async{
    await loadAppFonts();
    tester.view.physicalSize = Size(1200, 2500);
    tester.view.devicePixelRatio = 3.0;

    LoginViewModel viewModel = LoginViewModel(authRepository: MockAuthRepository());
    await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: LoginScreen(authBloc: AuthBloc(authRepository: MockAuthRepository())),
        )
    );
    await expectLater(find.byType(LoginScreen),
        matchesGoldenFile('register_sc.png'));
  });
}