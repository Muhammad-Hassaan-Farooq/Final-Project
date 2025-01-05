import 'package:final_project/ui/auth/view_models/login_view_model.dart';
import 'package:final_project/ui/auth/widgets/views/bottom_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final void Function() updatePage;
  final LoginFormState loginForm;
  final void Function(bool) changeRememberMe;
  final SignupFormState signupFormState;
  final Future<void> Function() register;
  final Future<void> Function() login;
  final Future<void> Function() google;
  const AuthScreen(
      {super.key,
      required this.updatePage,
      required this.loginForm,
      required this.changeRememberMe,
      required this.signupFormState,
      required this.register,
      required this.login,
      required this.google});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: updatePage,
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle, // Ensures the container is circular
                            border: Border.all(
                              color: Colors.white
                                  .withOpacity(0.5), // White circular border
                              width: 2.0, // Thickness of the border
                            ),
                            color: Colors.transparent,
                          ),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to Chronoscribe",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Sign in-up to seamlessly log your activities and capture meaningful insights.",
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
        BottomScreen(
            loginForm: loginForm,
            changeRememberMe: changeRememberMe,
            signupFormState: signupFormState,
            register: register,
            login: login,
            google:google)
      ],
    ));
  }
}