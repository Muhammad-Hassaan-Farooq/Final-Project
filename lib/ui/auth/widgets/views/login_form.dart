import 'package:final_project/ui/auth/view_models/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LoginFormState loginFormState;
  final void Function(bool) changeRememberMe;
  final Future<void> Function() login;
  final Future<void> Function() google;

  LoginForm(
      {super.key,
      required this.loginFormState,
      required this.changeRememberMe,
      required this.login,
      required this.google});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    controller: loginFormState.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Password Field
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: TextFormField(
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    controller: loginFormState.password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      prefixIcon: Icon(Icons.lock,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                              focusColor: Theme.of(context).colorScheme.primary,
                              value: loginFormState.isRememberMe,
                              onChanged: (value) {
                                changeRememberMe(value!);
                              }),
                          Text(
                            "Remember Me",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ElevatedButton(
                    onPressed: login,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 16,),
                    Expanded(
                      child: Divider(
                        color: Colors.grey, // Color of the line
                        thickness: 1,       // Thickness of the line
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or login with",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Text color
                        ),
                      ),
                    ),
                    // Right Line
                    Expanded(
                      child: Divider(
                        color: Colors.grey, // Color of the line
                        thickness: 1,       // Thickness of the line
                      ),
                    ),
                    SizedBox(width: 16,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: google, child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.mail),
                        Text("Google")
                      ],
                    )),
                    ElevatedButton(onPressed: (){}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.facebook),
                        Text("Facebook")
                      ],
                    ))
                  ],
                )
              ],
            ))
      ],
    );
  }
}
