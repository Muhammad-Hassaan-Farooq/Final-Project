import 'dart:ui';

import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:final_project/ui/core/theme.dart';
import 'package:final_project/ui/home/bloc/navbar/home_page_bloc.dart';
import 'package:final_project/ui/home/view_models/layout_view_model.dart';
import 'package:final_project/ui/home/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

void main() async {
  testWidgets("Home Screen Test", (WidgetTester tester) async {
    await loadAppFonts();
    tester.view.physicalSize = Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(MaterialApp(
      theme: lightTheme,
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthRepository>.value(
                value: MockAuthRepository()),
            ChangeNotifierProvider<ActivityRepository>.value(
                value: MockActivityRepository()),
          ],
          child: Layout(
              title: "Home Screen", navBarBloc: HomePageBloc(activityRepository: MockActivityRepository()),)),
    ));

    await expectLater(find.byType(Layout), matchesGoldenFile('home_sc.png'));
  });
}
