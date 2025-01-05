import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/material.dart';

enum Filter { ALL, SOLO, COLABS }
enum Status { LOADING, SUCCESS, ERROR}

class OldActivitiesViewModel extends ChangeNotifier {
  final ActivityRepository _activityRepository;
  Filter _currentFilter;
  Filter get currentFilter =>_currentFilter;

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
        _status = Status.LOADING;

  Future<void> changeFilter(Filter filter) async {
    _status = Status.LOADING;
    _currentFilter = filter;
    _activities = await _activityRepository.getPastActivities("");
    _status = Status.SUCCESS;
    notifyListeners();
  }
}
