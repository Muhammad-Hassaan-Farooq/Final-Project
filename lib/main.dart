import 'package:final_project/routing/router.dart';
import 'package:final_project/ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_dev.dart' as dev;

void main() {
  dev.main();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const ChronscribeApp(),
    );
  }
}

class ChronscribeApp extends StatelessWidget {
  const ChronscribeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router(context.read()),
    );
  }
}
