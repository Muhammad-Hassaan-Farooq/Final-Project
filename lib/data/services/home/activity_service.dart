import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/domain/home/activity.dart';

class ActivityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Activity>> getActivitiesForUser(String userId) async {
    final querySnapshot = await _firestore
        .collection('activities')
        .where('ownerId', isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => Activity.fromJson(doc.data()))
        .toList();
  }

  Future<void> addActivity(Activity activity) async {
    await _firestore
        .collection('activities')
        .doc(activity.id)
        .set(activity.toJson());
  }

  Future<void> updateActivity(Activity activity) async {
    await _firestore
        .collection('activities')
        .doc(activity.id)
        .update(activity.toJson());
  }

  Future<void> deleteActivity(String activityId) async {
    await _firestore.collection('activities').doc(activityId).delete();
  }

  Future<Activity?> getActivityById(String activityId) async {
    final doc = await _firestore.collection('activities').doc(activityId).get();
    if (doc.exists) {
      return Activity.fromJson(doc.data()!);
    }
    return null;
  }
  Future<List<Activity>> getTodaysActivities(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day); // 00:00 of today
    final endOfDay = startOfDay.add(Duration(days: 1)); // 23:59 of today

    final querySnapshot = await _firestore
        .collection('activities')
        .where('ownerId', isEqualTo: userId)
        .where('startTime', isGreaterThanOrEqualTo: startOfDay)
        .where('startTime', isLessThan: endOfDay)
        .get();

    return querySnapshot.docs
        .map((doc) => Activity.fromJson(doc.data()))
        .toList();
  }
  Future<List<Activity>> getFutureActivities(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day); // 00:00 of today

    final querySnapshot = await _firestore
        .collection('activities')
        .where('ownerId', isEqualTo: userId)
        .where('startTime', isGreaterThan: startOfDay) // Exclude today
        .get();

    return querySnapshot.docs
        .map((doc) => Activity.fromJson(doc.data()))
        .toList();
  }

  Future<List<Activity>> getPastActivities(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day); // 00:00 of today

    final querySnapshot = await _firestore
        .collection('activities')
        .where('ownerId', isEqualTo: userId)
        .where('endTime', isLessThan: startOfDay) // Exclude today
        .get();

    return querySnapshot.docs
        .map((doc) => Activity.fromJson(doc.data()))
        .toList();
  }
}