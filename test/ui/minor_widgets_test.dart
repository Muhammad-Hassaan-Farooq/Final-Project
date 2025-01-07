import 'package:final_project/ui/home/widgets/activity_card.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  setUp(() {
  });

  testWidgets("Activity Card - Own Activity Today", (WidgetTester tester) async {

    tester.view.physicalSize = Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;

    await loadAppFonts();

    final activity = Activity(
      id: '1',
      title: 'Team Meeting',
      ownerId: 'user_001',
      collaborators: [],
      status: 'Scheduled',
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
      duration: Duration(hours: 1),
      category: 'Work',
    );

    await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: ActivityCard(
              activity: activity,
              isOwn: true,
              isToday: true,
              delete: () {},
              showModal: () {},
            ),
          ),
        )
    );

    await expectLater(
        find.byType(ActivityCard),
        matchesGoldenFile('activity_card_own_today.png')
    );
  });

  testWidgets("Activity Card - Collaborator Activity", (WidgetTester tester) async {
    await loadAppFonts();

    tester.view.physicalSize = Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;

    final activity = Activity(
      id: '2',
      title: 'Project Review',
      ownerId: 'user_002',
      collaborators: ['user_001'],
      status: 'Scheduled',
      startTime: DateTime.now().add(Duration(days: 1)),
      endTime: DateTime.now().add(Duration(days: 1, hours: 2)),
      duration: Duration(hours: 2),
      category: 'Work',
    );

    await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: ActivityCard(
              activity: activity,
              isOwn: false,
              isToday: false,
              remove: () {},
            ),
          ),
        )
    );

    await expectLater(
        find.byType(ActivityCard),
        matchesGoldenFile('activity_card_collaborator.png')
    );
  });

  testWidgets("Activity Card - Past Activity", (WidgetTester tester) async {
    await loadAppFonts();
    tester.view.physicalSize = Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;

    final activity = Activity(
      id: '3',
      title: 'Past Meeting',
      ownerId: 'user_001',
      collaborators: [],
      status: 'Completed',
      startTime: DateTime.now().subtract(Duration(days: 3)),
      endTime: DateTime.now().subtract(Duration(days: 3, hours: 1)),
      duration: Duration(hours: 1),
      category: 'Work',
    );

    await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: ActivityCard(
              activity: activity,
              isOwn: true,
              isToday: false,
              delete: () {},
            ),
          ),
        )
    );

    await expectLater(
        find.byType(ActivityCard),
        matchesGoldenFile('activity_card_past.png')
    );
  });

  testWidgets("Activity Card - Future Activity", (WidgetTester tester) async {
    await loadAppFonts();
    tester.view.physicalSize = Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;

    final activity = Activity(
      id: '4',
      title: 'Future Conference',
      ownerId: 'user_001',
      collaborators: [],
      status: 'Scheduled',
      startTime: DateTime.now().add(Duration(days: 7)),
      endTime: DateTime.now().add(Duration(days: 7, hours: 4)),
      duration: Duration(hours: 4),
      category: 'Work',
    );

    await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: ActivityCard(
              activity: activity,
              isOwn: true,
              isToday: false,
              delete: () {},
            ),
          ),
        )
    );

    await expectLater(
        find.byType(ActivityCard),
        matchesGoldenFile('activity_card_future.png')
    );
  });




  testWidgets("Activity Card - Different Screen Size", (WidgetTester tester) async {
    await loadAppFonts();


    tester.view.physicalSize = Size(1440, 2560);
    tester.view.devicePixelRatio = 4.0;

    final activity = Activity(
      id: '6',
      title: 'Team Meeting',
      ownerId: 'user_001',
      collaborators: [],
      status: 'Scheduled',
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
      duration: Duration(hours: 1),
      category: 'Work',
    );

    await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: ActivityCard(
              activity: activity,
              isOwn: true,
              isToday: true,
              delete: () {},
              showModal: () {},
            ),
          ),
        )
    );

    await expectLater(
        find.byType(ActivityCard),
        matchesGoldenFile('activity_card_large_screen.png')
    );
  });
}