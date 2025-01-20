import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/routing/routes.dart';
import 'package:final_project/ui/activity/view_models/activity_view_model.dart';
import 'package:final_project/ui/activity/widgets/activity_notes.dart';
import 'package:final_project/ui/auth/bloc/auth_bloc.dart';
import 'package:final_project/ui/auth/widgets/login_screen.dart';
import 'package:final_project/ui/core/widgets/splash_screen.dart';
import 'package:final_project/ui/home/bloc/navbar/home_page_bloc.dart';
import 'package:final_project/ui/home/bloc/update_activity/update_activity_bloc.dart';
import 'package:final_project/ui/home/widgets/create_activity_page.dart';
import 'package:final_project/ui/home/widgets/layout.dart';
import 'package:final_project/ui/home/widgets/update_activity_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/core/view_models/splash_screen_view_model.dart';
import '../ui/home/bloc/create_activity/create_activity_bloc.dart';

GoRouter router(
  AuthRepository authRepository,
) =>
    GoRouter(
        initialLocation: Routes.splash,
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
                  authBloc: AuthBloc(authRepository: context.read()),
                );
              }),
          GoRoute(
              path: Routes.home,
              builder: (context, state) {
                return Layout(
                  navBarBloc: HomePageBloc(activityRepository: context.read()),
                  title: "Activities",
                );
              }),
          GoRoute(
              path: Routes.splash,
              builder: (context, state) {
                return SplashScreen(
                  viewModel:
                      SplashScreenViewModel(authRepository: context.read()),
                );
              }),
          GoRoute(
              path: '${Routes.activityNotes}/:id',
              builder: (context, state) {
                final activityId = state.pathParameters['id']!;
                final activity = state.extra as Activity;
                return ActivityNotes(
                    viewModel: ActivityViewModel(
                        activityRepository: context.read(),
                        noteRepository: context.read(),
                        activityId: activityId,
                        activity: activity));
              }),
          GoRoute(
              path: Routes.createActivity,
              builder: (context, state) {
                return CreateActivityPage(
                  createActivityBloc:
                      CreateActivityBloc(activityRepository: context.read()),
                );
              }),
          GoRoute(
              path: '${Routes.updateActivity}/:id',
              builder: (context, state) {
                final activityId = state.pathParameters['id']!;
                final activity = state.extra as Activity;

                return UpdateActivityPage(
                  updateActivityBloc: UpdateActivityBloc(
                      activity: activity,
                      activityId: activityId,
                      activityRepository: context.read()),
                );
              })
        ]);
