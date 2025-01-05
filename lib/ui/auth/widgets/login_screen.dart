import 'dart:math';
import 'package:final_project/ui/auth/widgets/views/auth_screen.dart';
import 'package:final_project/ui/auth/widgets/views/start_screen.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:provider/provider.dart';

import '../view_models/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {

                final reverse = animation.drive(Tween(begin: 1.0, end: 0.0));
                bool isMovingForward = viewModel.currentPage == Page.AUTH;


                final slideAnimation = animation.drive(
                  Tween<Offset>(
                    begin: Offset(isMovingForward ? 1.0 : -1.0, 0.0),
                    end: Offset.zero,
                  ),
                );


                final slideOutAnimation = reverse.drive(
                  Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(isMovingForward ? -1.0 : 1.0, 0.0),
                  ),
                );

                final currentAnimation = child.key == ValueKey(viewModel.currentPage)
                    ? slideAnimation
                    : slideOutAnimation;

                return SlideTransition(
                  position: currentAnimation,
                  child: child,
                );
              },
              child: Builder(
                key: ValueKey(viewModel.currentPage),
                builder: (context) {
                  switch (viewModel.currentPage) {
                    case Page.START:
                      return StartScreen(
                        updatePage: () => viewModel.updatePage(Page.AUTH),
                      );
                    case Page.AUTH:
                      return AuthScreen(
                        updatePage: () => viewModel.updatePage(Page.START),
                        loginForm: viewModel.loginForm,
                        changeRememberMe: viewModel.setRememberMe,
                        signupFormState: viewModel.signupForm,
                        register: viewModel.register,
                        login: viewModel.login,
                        google:viewModel.signInWithGoogle
                      );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}