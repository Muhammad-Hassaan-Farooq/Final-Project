import 'package:final_project/ui/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(onPressed: viewModel.logout, icon: const Icon(Icons.logout))
        ],),
    );
  }
}