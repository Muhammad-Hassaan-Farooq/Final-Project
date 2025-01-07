 import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/material.dart';

abstract class ActivityRepository extends ChangeNotifier {

  Future<List<Activity>> getActivities(String userId);

  Future<void> addActivity(Activity activity);

  Future<void> updateActivity(Activity activity);

  Future<void> deleteActivity(String activityId);

  Future<void> removeActivity(String activityId);

  /// Get a single activity by its ID
  Future<Activity?> getActivityById(String activityId);
  Stream<List<Activity>> getTodaysActivitiesStream();
  Stream<List<Activity>> getUpcomingActivites();
  Stream<List<Activity>> getPastActivities();

  Future<List<Map<String, dynamic>>> fetchCollaborators();
  String get currentUser;
  }

