 import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/material.dart';

abstract class ActivityRepository extends ChangeNotifier {
  /// Fetch all activities for a specific user
  Future<List<Activity>> getActivities(String userId);

  /// Add a new activity
  Future<void> addActivity(Activity activity);

  /// Update an existing activity
  Future<void> updateActivity(Activity activity);

  /// Delete an activity by its ID
  Future<void> deleteActivity(String activityId);

  /// Get a single activity by its ID
  Future<Activity?> getActivityById(String activityId);
  Future<List<Activity>> getTodaysActivities(String userId);
  Future<List<Activity>> getUpcomingActivites(String userId);
  Future<List<Activity>> getPastActivities(String userId);
  }

