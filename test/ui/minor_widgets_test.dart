import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:final_project/ui/home/bloc/navbar/home_page_bloc.dart';
import 'package:final_project/ui/home/widgets/activity_card.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/ui/core/theme.dart';
import 'package:final_project/ui/home/widgets/bottom_nav_bar.dart';
import 'package:final_project/ui/home/widgets/ongoing_activities.dart';
import 'package:final_project/ui/home/widgets/upcoming_activities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {

  List<Activity> activities = [
    Activity(
      id: '1',
      title: 'Team Meeting',
      ownerId: 'user1',
      collaborators: ['user2', 'user3'],
      status: 'Incomplete',
      startTime: DateTime(2025, 1, 20, 10, 0),
      endTime: DateTime(2025, 1, 20, 11, 0),
      duration: Duration(hours: 1),
      category: 'Work',
    ),
    Activity(
      id: '2',
      title: 'Workout Session',
      ownerId: 'user2',
      collaborators: ['user1'],
      status: 'Completed',
      startTime: DateTime(2025, 1, 20, 14, 0),
      endTime: DateTime(2025, 1, 20, 15, 0),
      duration: Duration(hours: 1),
      category: 'Fitness',
    ),
    Activity(
      id: '3',
      title: 'Study Group',
      ownerId: 'user3',
      collaborators: ['user1', 'user2'],
      status: 'Incomplete',
      startTime: DateTime(2025, 1, 20, 17, 0),
      endTime: DateTime(2025, 1, 20, 18, 0),
      duration: Duration(hours: 1),
      category: 'Education',
    ),
  ];

  setUp(() {});

  testWidgets("Bottom Nav Bar", (WidgetTester tester) async {
    await loadAppFonts();

    tester.view.physicalSize = Size(1440, 2560);
    tester.view.devicePixelRatio = 4.0;

    await tester.pumpWidget(MaterialApp(
      theme: lightTheme,
      home: Scaffold(
        body: BlocProvider(
          create: (_) => HomePageBloc(
              activityRepository: MockActivityRepository(),
              authRepository: MockAuthRepository()),
          child: BottomNavBar(),
        ),
      ),
    ));

    await expectLater(
        find.byType(BottomNavBar), matchesGoldenFile('bottom_nav_bar.png'));
  });

  testWidgets("Upcoming Activities", (WidgetTester tester) async {
    await loadAppFonts();

    tester.view.physicalSize = Size(1440, 2560);
    tester.view.devicePixelRatio = 4.0;

    await tester.pumpWidget(MaterialApp(
      theme: lightTheme,
      home: Scaffold(
        body: BlocProvider(
          create: (_) => HomePageBloc(
              activityRepository: MockActivityRepository(),
              authRepository: MockAuthRepository()),
          child: UpcomingActivities(activities: activities),
        ),
      ),
    ));

    await expectLater(
        find.byType(UpcomingActivities), matchesGoldenFile('upcoming.png'));
  });

  testWidgets("Ongoing Activities", (WidgetTester tester) async {
    await loadAppFonts();

    tester.view.physicalSize = Size(1440, 2560);
    tester.view.devicePixelRatio = 4.0;

    await tester.pumpWidget(MaterialApp(
      theme: lightTheme,
      home: Scaffold(
        body: BlocProvider(
          create: (_) => HomePageBloc(
              activityRepository: MockActivityRepository(),
              authRepository: MockAuthRepository()),
          child: OngoingActivities(activities: activities),
        ),
      ),
    ));

    await expectLater(
        find.byType(OngoingActivities), matchesGoldenFile('ongoing.png'));
  });


}
