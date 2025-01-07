
import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:final_project/routing/router.dart';
import 'package:final_project/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async{
  late MockAuthRepository mockAuthRepository;
  late ActivityRepository mockActivityRepository;
  late GoRouter goRouter;



  setUp(() async{
    mockAuthRepository = MockAuthRepository();
    mockActivityRepository = MockActivityRepository();
    goRouter = router(mockAuthRepository);
  });

  group("Router Tests", (){
    testWidgets('Should redirect to login screen when not logged in',
            (WidgetTester tester) async {

          mockAuthRepository.setAuthState = true;
          mockAuthRepository.setLoggedInState = false;


          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthRepository>.value(value: mockAuthRepository),
              ],
              child: MaterialApp.router(
                routerConfig: goRouter,
              ),
            ),
          );
          await tester.pumpAndSettle();


          expect(goRouter.state!.matchedLocation, Routes.login);
        });

    testWidgets('Should redirect to home screen when logged in',
            (WidgetTester tester) async {

          mockAuthRepository.setAuthState = true;
          mockAuthRepository.setLoggedInState = true;


          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthRepository>.value(value: mockAuthRepository),
                ChangeNotifierProvider<ActivityRepository>.value(value: mockActivityRepository),
              ],
              child: MaterialApp.router(
                routerConfig: goRouter,
              ),
            ),
          );
          await tester.pumpAndSettle();


          expect(goRouter.state!.matchedLocation, Routes.home);
        });
  });




}

