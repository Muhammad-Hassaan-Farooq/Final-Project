import 'package:final_project/config/dependencies.dart';
import 'package:final_project/routing/router.dart';
import 'package:final_project/ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'main_dev.dart' as dev;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPaintSizeEnabled = false;
  debugRepaintRainbowEnabled = false;
  //dev.main();
  runApp(
      MultiProvider(
        providers: providersNetwork,
        child:const ChronscribeApp(),)
  );
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
