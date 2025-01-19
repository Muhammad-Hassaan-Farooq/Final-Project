import 'package:final_project/ui/auth/bloc/auth_bloc.dart';
import 'package:final_project/ui/auth/widgets/views/auth_screen.dart';
import 'package:final_project/ui/auth/widgets/views/start_screen.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.authBloc});
  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                final reverse = animation.drive(Tween(begin: 1.0, end: 0.0));
                bool isMovingForward = state is AuthScreenState;

                final slideAnimation = animation.drive(
                  Tween(
                    begin: Offset(isMovingForward ? 1.0 : -1.0, 0.0),
                    end: Offset.zero,
                  ),
                );

                final slideOutAnimation = reverse.drive(
                  Tween(
                    begin: Offset.zero,
                    end: Offset(isMovingForward ? -1.0 : 1.0, 0.0),
                  ),
                );

                final currentAnimation = child.key == ValueKey(state.runtimeType)
                    ? slideAnimation
                    : slideOutAnimation;

                return SlideTransition(
                  position: currentAnimation,
                  child: child,
                );
              },
              child: Builder(
                key: ValueKey(state.runtimeType),
                builder: (context) {
                  if (state is StartScreenState) {
                    return StartScreen(
                      updatePage: () => {
                        context
                            .read<AuthBloc>()
                            .add(const ChangePageEvent(page: Page.AUTH))
                      },
                    );
                  } else if (state is AuthScreenState) {
                    return AuthScreen(
                      updatePage: () => {
                        context
                            .read<AuthBloc>()
                            .add(const ChangePageEvent(page: Page.START))
                      },
                    );
                  } else {
                    return Container();
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
