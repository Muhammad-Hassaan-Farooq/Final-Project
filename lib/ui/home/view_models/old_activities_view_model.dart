import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/material.dart';

enum Filter { ALL, SOLO, COLABS }
enum Status { LOADING, SUCCESS, ERROR}

class OldActivitiesViewModel extends ChangeNotifier {
  final ActivityRepository _activityRepository;
  Filter _currentFilter;
  Filter get currentFilter =>_currentFilter;

  Stream<List<Activity>>? _activityStream;

  late List<Activity> _activities;
  List<Activity> get activities {
    switch(_currentFilter){

      case Filter.ALL:
        return _activities;
      case Filter.SOLO:
        return _activities.where((activity) => activity.collaborators.isEmpty).toList();
      case Filter.COLABS:
        return _activities.where((activity) => activity.collaborators.isNotEmpty).toList();
    }
  }

  Status _status ;
  Status get currentStatus => _status;

  OldActivitiesViewModel({required ActivityRepository activityRepository})
      : _activityRepository = activityRepository,
        _currentFilter = Filter.ALL,
        _status = Status.LOADING{
    init();
  }

  void init() {
    _activityStream = _activityRepository.getPastActivities();
    _activityStream!.listen(
          (updatedActivities) {
        _activities = updatedActivities;
        _activities.sort((a, b) => a.startTime!.compareTo(b.startTime!));
        _status = Status.SUCCESS;
        notifyListeners();
      },
      onError: (error) {
            print(error);
        _status = Status.ERROR;
        notifyListeners();
      },
    );
  }

  Future<void> changeFilter(Filter filter) async {
    _currentFilter = filter;
    notifyListeners();
  }

  void delete(String activityId){
    _activityRepository.deleteActivity(activityId);
  }
  void remove(String activityId){
    _activityRepository.removeActivity(activityId);
  }
}
