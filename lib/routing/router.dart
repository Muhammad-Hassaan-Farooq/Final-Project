import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/routing/routes.dart';
import 'package:final_project/ui/auth/widgets/login_screen.dart';
import 'package:final_project/ui/core/widgets/splash_screen.dart';
import 'package:final_project/ui/home/view_models/layout_view_model.dart';
import 'package:final_project/ui/home/view_models/today_activities_view_model.dart';
import 'package:final_project/ui/home/widgets/layout.dart';
import 'package:final_project/ui/home/widgets/today_activities.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/auth/view_models/login_view_model.dart';
import '../ui/core/view_models/splash_screen_view_model.dart';

GoRouter router(
  AuthRepository authRepository,
) =>
    GoRouter(
        initialLocation: Routes.home,
        debugLogDiagnostics: true,
        refreshListenable: authRepository,
        redirect: (context, state) {
          print(
              "Redirect: AuthKnown=${authRepository.isAuthStateLoaded}, LoggedIn=${authRepository.isAuthenticated}, State=${state.uri.toString()}");
          final isAuthKnown = authRepository.isAuthStateLoaded;
          if (!isAuthKnown) {
            return Routes.splash;
          }
          final isLoggedIn = authRepository.isAuthenticated;

          if (!isLoggedIn && state.matchedLocation != Routes.login) {
            return Routes.login;
          }
          if (isLoggedIn && state.matchedLocation == Routes.login) {
            return Routes.home;
          }
          if (isLoggedIn && state.matchedLocation == Routes.splash) {
            return Routes.home;
          }
          return null;
        },
        routes: [
          GoRoute(
              path: Routes.login,
              builder: (context, state) {
                return LoginScreen(
                  viewModel: LoginViewModel(authRepository: context.read()),
                );
              }),
          GoRoute(
              path: Routes.home,
              builder: (context, state) {
                return Layout(
                  viewModel: LayoutViewModel(authRepository: context.read()),
                  title: "Home Screem",
                );
              }),
          GoRoute(
              path: Routes.splash,
              builder: (context, state) {
                return SplashScreen(
                  viewModel:
                      SplashScreenViewModel(authRepository: context.read()),
                );
              })
        ]);