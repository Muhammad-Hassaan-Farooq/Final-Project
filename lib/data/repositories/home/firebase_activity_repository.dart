import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/data/services/home/activity_service.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseActivityRepository extends ActivityRepository {
  final ActivityService _activityService = ActivityService();

  FirebaseActivityRepository();

  @override
  Future<List<Activity>> getActivities(String userId) async {
    final activities = await _activityService.getActivitiesForUser(userId);
    return activities;
  }

  @override
  Future<void> addActivity(Activity activity) async {
    await _activityService.addActivity(activity);
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    await _activityService.updateActivity(activity);
  }

  @override
  Future<void> deleteActivity(String activityId) async {
    await _activityService.deleteActivity(activityId);
  }
  @override
  Future<void> removeActivity(String activityId) async {
    await _activityService.removeActivity(activityId);
  }

  @override
  Future<Activity?> getActivityById(String activityId) async {
    return await _activityService.getActivityById(activityId);
  }
  @override
  Stream<List<Activity>> getTodaysActivitiesStream(){

    return _activityService.getTodaysActivities();
  }

  @override
  Stream<List<Activity>> getUpcomingActivites(){
    return _activityService.getFutureActivities();
  }

  @override
  Stream<List<Activity>> getPastActivities() {
    return _activityService.getPastActivities();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchCollaborators() {
    return _activityService.fetchCollaborators();
  }

  @override
  // TODO: implement currentUser
  String get currentUser => FirebaseAuth.instance.currentUser!.uid;
}
