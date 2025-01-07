import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Filter { ALL, SOLO, COLABS }

enum Status { LOADING, SUCCESS, ERROR }

class TodayActivitiesViewModel extends ChangeNotifier {
  final ActivityRepository _activityRepository;
  Filter _currentFilter;
  Filter get currentFilter => _currentFilter;

  late List<Activity> _activities;
  List<Activity> get activities {
    switch (_currentFilter) {
      case Filter.ALL:
        return _activities;
      case Filter.SOLO:
        return _activities
            .where((activity) => activity.collaborators.isEmpty)
            .toList();
      case Filter.COLABS:
        return _activities
            .where((activity) => activity.collaborators.isNotEmpty)
            .toList();
    }
  }

  Status _status;
  Status get currentStatus => _status;

  Stream<List<Activity>>? _activityStream;

  TodayActivitiesViewModel({required ActivityRepository activityRepository})
      : _activityRepository = activityRepository,
        _currentFilter = Filter.ALL,
        _status = Status.LOADING {
    init();
  }

  void init() {
    _activityStream = _activityRepository.getTodaysActivitiesStream();
    _activityStream!.listen(
      (updatedActivities) {
        _activities = updatedActivities;
        _status = Status.SUCCESS;
        _activities.sort((a, b) => a.startTime!.compareTo(b.startTime!));
        notifyListeners();
      },
      onError: (error) {
        _status = Status.ERROR;
        notifyListeners();
      },
    );
  }

  bool isOwn(Activity activity) {
    return activity.ownerId == FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> changeFilter(Filter filter) async {
    _currentFilter = filter;
    notifyListeners();
  }

  void stopListening() {
    _activityStream?.drain();
  }

  void delete(String activityId) {
    _activityRepository.deleteActivity(activityId);
  }

  Future<List<Map<String, dynamic>>> getCollaborators() async {

    return _activityRepository.fetchCollaborators();
  }

  void update(
      {required String activityId,
      required String title,
      required String category,
      required DateTime startTime,
      required DateTime endTime,
      required Activity activity,
        required List<String> collaborators}) {

    _activityRepository.updateActivity(activity.copyWith(
      title: title,
      category: category,
      startTime: startTime,
      endTime: endTime,
      collaborators: collaborators
    ));
  }
  void remove(String activityId) {
    _activityRepository.removeActivity(activityId);
  }

  Future<void> add({
    required String title,
    required String category,
    required DateTime startTime,
    required DateTime endTime,
    required List<String> collaborators
  }) async {
    _activityRepository.addActivity(Activity(
        id: "1",
        title: title,
        ownerId: FirebaseAuth.instance.currentUser!.uid,
        collaborators: collaborators,
        status: "Incomplete",
        category: category,
        startTime: startTime,
        endTime: endTime));
  }
}
