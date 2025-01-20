part of 'activity_bloc.dart';

abstract class ActivityState {
  final Activity activity;
  final List<Note> notes;
  final bool isActive;

  ActivityState(this.activity, this.notes, this.isActive);
}

class ActivityLoadingState extends ActivityState {
  ActivityLoadingState(Activity activity) : super(activity, [], false);
}

class ActivityLoadedState extends ActivityState {
  ActivityLoadedState(Activity activity, List<Note> notes, bool isActive)
      : super(activity, notes, isActive);
}

class ActivityErrorState extends ActivityState {
  final String error;
  ActivityErrorState(Activity activity, this.error) : super(activity, [], false);
}