import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/routing/routes.dart';
import 'package:final_project/ui/auth/widgets/login_screen.dart';
import 'package:final_project/ui/core/widgets/splash_screen.dart';
import 'package:final_project/ui/home/widgets/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/auth/view_models/login_view_model.dart';
import '../ui/core/view_models/splash_screen_view_model.dart';
import '../ui/home/view_models/home_view_model.dart';

GoRouter router(
    AuthRepository authRepository,
    ) => GoRouter(
    initialLocation: Routes.home, debugLogDiagnostics: true , refreshListenable: authRepository,
    redirect: (context,state){
      final isAuthKnown = authRepository.isAuthStateLoaded;
      if(!isAuthKnown) {
        return Routes.splash;
      } else {
        final isLoggedin = authRepository.isAuthenticated;
        return isLoggedin?Routes.home:Routes.login;
      }
    },
    routes: [
      GoRoute(
          path: Routes.login,
          builder: (context,state){
            return LoginScreen(
              viewModel: LoginViewModel(
                authRepository: context.read()
              ),
            );
          }
      ),
      GoRoute(
          path: Routes.home,
          builder: (context,state){
            return HomeScreen(
              viewModel: HomeViewModel(
                authRepository: context.read()
              ),
            );
          }
      ),
      GoRoute(
          path: Routes.splash,
          builder: (context,state){
            return SplashScreen(
              viewModel: SplashScreenViewModel(
                authRepository: context.read()
              ),
            );
          }
      )
]);

