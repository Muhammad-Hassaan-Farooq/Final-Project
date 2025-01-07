import 'package:final_project/ui/auth/view_models/login_view_model.dart';
import 'package:final_project/ui/auth/widgets/views/login_form.dart';
import 'package:final_project/ui/auth/widgets/views/signup_form.dart';
import 'package:flutter/material.dart';

class BottomScreen extends StatefulWidget {
  final LoginFormState loginForm;
  final void Function(bool) changeRememberMe;
  final SignupFormState signupFormState;
  final Future<void> Function() register;
  final Future<void> Function() login;
  final Future<void> Function() google;
  const BottomScreen(
      {super.key,
      required this.loginForm,
      required this.changeRememberMe,
      required this.signupFormState,
      required this.register,
      required this.login,
      required this.google});

  @override
  State<StatefulWidget> createState() => _BottomScreen();
}

class _BottomScreen extends State<BottomScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              )),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black54,
                      tabs: const [
                        Text("Register"),
                        Text("Login"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                SignupForm(
                    signupFormState: widget.signupFormState,
                    register: widget.register,
                    google: widget.google),
                LoginForm(
                  loginFormState: widget.loginForm,
                  changeRememberMe: widget.changeRememberMe,
                  login:widget.login,
                  google:widget.google
                )
              ]))
            ],
          )),
    );
  }
}
