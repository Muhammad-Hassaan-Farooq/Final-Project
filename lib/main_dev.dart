
import 'package:final_project/config/dependencies.dart';
import 'package:final_project/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    MultiProvider(
      providers: providersMock,
      child:const ChronscribeApp(),)
  );
}