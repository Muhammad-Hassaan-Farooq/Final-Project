import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/ui/core/view_models/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key,required this.viewModel});

  final SplashScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.checkAuthStatus();
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text(
        style: TextStyle(
            color: Color(0xFFFddbb7), fontSize: 32, fontWeight: FontWeight.bold),
            "ChronoScribe"),

      ),
    );
  }
}