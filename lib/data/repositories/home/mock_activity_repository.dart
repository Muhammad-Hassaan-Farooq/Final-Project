import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';

class MockActivityRepository extends ActivityRepository {

  final List<Activity> _mockActivities = [
    Activity(
      id: '1',
      title: 'Team Meeting',
      ownerId: 'user_001',
      collaborators: [],
      status: 'Scheduled',
      startTime: DateTime.now().add(Duration(hours: 1)),
      endTime: DateTime.now().add(Duration(hours: 2)),
      duration: Duration(hours: 1),
      category: 'Work',
    ),
    Activity(
      id: '2',
      title: 'Project Deadline',
      ownerId: 'user_002',
      collaborators: ['user_001'],
      status: 'Completed',
      startTime: DateTime.now().subtract(Duration(days: 2)),
      endTime: DateTime.now().subtract(Duration(days: 2)).add(Duration(hours: 3)),
      duration: Duration(hours: 3),
      category: 'Work',
    ),
    Activity(
      id: '3',
      title: 'Yoga Class',
      ownerId: 'user_003',
      collaborators: [],
      status: 'Ongoing',
      startTime: DateTime.now().subtract(Duration(minutes: 30)),
      endTime: null, // Ongoing activity
      duration: null,
      category: 'Health',
    ),
    Activity(
      id: '4',
      title: 'Code Review',
      ownerId: 'user_001',
      collaborators: ['user_002'],
      status: 'Scheduled',
      startTime: DateTime.now().add(Duration(days: 1)),
      endTime: DateTime.now().add(Duration(days: 1, hours: 2)),
      duration: Duration(hours: 2),
      category: 'Work',
    ),
    Activity(
      id: '5',
      title: 'Birthday Party',
      ownerId: 'user_002',
      collaborators: ['user_001', 'user_003'],
      status: 'Scheduled',
      startTime: DateTime.now().add(Duration(days: 3)),
      endTime: DateTime.now().add(Duration(days: 3, hours: 4)),
      duration: Duration(hours: 4),
      category: 'Personal',
    ),
    Activity(
      id: '6',
      title: 'Conference Talk',
      ownerId: 'user_001',
      collaborators: [],
      status: 'Completed',
      startTime: DateTime.now().subtract(Duration(days: 7)),
      endTime: DateTime.now().subtract(Duration(days: 7)).add(Duration(hours: 2)),
      duration: Duration(hours: 2),
      category: 'Work',
    )
  ];

  @override
  Future<List<Activity>> getActivities(String userId) async {
    // Return activities belonging to the given userId
    return _mockActivities.where((activity) => activity.ownerId == userId)
        .toList();
  }

  @override
  Future<List<Activity>> getTodaysActivities(String userId) {
    final now = DateTime.now();
    return Future.delayed(Duration(seconds: 1), () {
      return _mockActivities.where((activity) {
        return activity.startTime != null && activity.startTime!.isAfter(now);
      }).toList();
    });
  }

  @override
  Future<void> addActivity(Activity activity) async {
    _mockActivities.add(activity);
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    final index = _mockActivities.indexWhere((a) => a.id == activity.id);
    if (index != -1) {
      _mockActivities[index] = activity;
    }
  }

  @override
  Future<void> deleteActivity(String activityId) async {
    _mockActivities.removeWhere((activity) => activity.id == activityId);
  }

  @override
  Future<Activity?> getActivityById(String activityId) async {
    try {
      return _mockActivities.firstWhere((activity) => activity.id == activityId,
          orElse: () => null as Activity);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Activity>> getUpcomingActivites(String userId) {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1); // Start of tomorrow

    return Future.delayed(const Duration(seconds: 1), () {
      return _mockActivities.where((activity) {
        return activity.startTime != null && activity.startTime!.isAfter(tomorrow);
      }).toList();
    });
  }

  @override
  Future<List<Activity>> getPastActivities(String userId) {
    final now = DateTime.now();
    return Future.delayed(Duration(seconds: 1), () {
      return _mockActivities.where((activity) {
        return activity.endTime != null && activity.endTime!.isBefore(now);
      }).toList();
    });
  }
}
