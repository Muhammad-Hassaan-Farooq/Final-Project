import 'package:final_project/ui/core/view_models/splash_screen_view_model.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key,required this.viewModel});

  final SplashScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.checkAuthStatus();
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