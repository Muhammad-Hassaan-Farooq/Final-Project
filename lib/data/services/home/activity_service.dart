import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<List<Map<String, dynamic>>> fetchCollaborators() async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('users');
      final snapshot = await usersCollection.get();

      return snapshot.docs
          .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
          .map((doc) => {
        'uid': doc.id,
        'displayName': doc['displayName'],
        'email': doc['email'],
      })
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addActivity(Activity activity) async {
    await _firestore
        .collection('activities')
        .add({
      'title': activity.title,
      'ownerId': FirebaseAuth.instance.currentUser!.uid,
      'collaborators': activity.collaborators,
      'status': activity.status,
      'category': activity.category,
      "startTime": activity.startTime,
      "endTime":activity.endTime,
      "duration":activity.duration
    });
  }

  Future<void> updateActivity(Activity activity) async {
    await _firestore
        .collection('activities')
        .doc(activity.id)
        .update({
      'title': activity.title,
      'collaborators': activity.collaborators,
      'status': activity.status,
      'category': activity.category,
      "startTime": activity.startTime,
      "endTime":activity.endTime,
      "duration":activity.duration
    });
  }

  Future<void> deleteActivity(String activityId) async {
    await _firestore.collection('activities').doc(activityId).delete();
  }
  
  Future<void> removeActivity(String activityId) async{
    final User user = FirebaseAuth.instance.currentUser!;
    await _firestore.collection('activities').doc(activityId).update({
      'collaborators': FieldValue.arrayRemove([user.uid])
    });
  }

  Future<Activity?> getActivityById(String activityId) async {
    final doc = await _firestore.collection('activities').doc(activityId).get();
    if (doc.exists) {
      return Activity.fromJson(doc.data()!);
    }
    return null;
  }
  Stream<List<Activity>> getTodaysActivities() {

    final User user = FirebaseAuth.instance.currentUser!;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    return _firestore
        .collection('activities')
        .where('startTime', isGreaterThanOrEqualTo: startOfDay)
        .where('startTime', isLessThan: endOfDay)
        .snapshots()
        .map((querySnapshot) {

      return querySnapshot.docs
          .where((doc) {
        final data = doc.data();
        return data['ownerId'] == user.uid || (data['collaborators'] as List).contains(user.uid);
      })
          .map((doc) => Activity.fromFirestore(doc))
          .toList();
    });
  }

  Stream<List<Activity>> getFutureActivities() {
    final User user = FirebaseAuth.instance.currentUser!;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    return _firestore
        .collection('activities')
        .where('startTime', isGreaterThanOrEqualTo: endOfDay)
        .snapshots()
        .map((querySnapshot) {

      return querySnapshot.docs
          .where((doc) {
        final data = doc.data();
        return data['ownerId'] == user.uid || (data['collaborators'] as List).contains(user.uid);
      })
          .map((doc) => Activity.fromFirestore(doc))
          .toList();
    });
  }

  Stream<List<Activity>> getPastActivities() {
    final User user = FirebaseAuth.instance.currentUser!;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    return _firestore
        .collection('activities')
        .where('startTime', isLessThanOrEqualTo: startOfDay)
        .where('collaborators', arrayContains: user.uid) // Check if user is in collaborators
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .where((doc) {
        final data = doc.data();
        return data['ownerId'] == user.uid || (data['collaborators'] as List).contains(user.uid);
      })
          .map((doc) => Activity.fromFirestore(doc))
          .toList();
    });

  }
}