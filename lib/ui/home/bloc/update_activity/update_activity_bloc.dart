import 'package:equatable/equatable.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_activity_event.dart';
part 'update_activity_state.dart';

class UpdateActivityBloc
    extends Bloc<UpdateActivityEvent, UpdateActivityState> {
  final String activityId;
  Activity activity;
  final ActivityRepository activityRepository;

  UpdateActivityBloc(
      {required this.activity,
      required this.activityId,
      required this.activityRepository})
      : super(UpdateActivityState(
            title: activity.title,
            category: activity.category,
            startTime: activity.startTime,
            endTime: activity.endTime)) {
    on<ChangeFormInputEvent>(_onInputChange);
    on<SubmitEvent>(_onSubmit);
  }

  void _onInputChange(
      ChangeFormInputEvent event, Emitter<UpdateActivityState> emit) {
    emit(UpdateActivityState(
      title: event.title ?? state.title,
      category: event.category ?? state.category,
      startTime: event.startTime ?? state.startTime,
      endTime: event.endTime ?? state.endTime,
    ));
  }

  void _onSubmit(SubmitEvent event, Emitter<UpdateActivityState> emit) async{
    try {

      activity = Activity(
          id: activityId,
          title: state.title ?? activity.title,
          ownerId: activity.ownerId,
          collaborators: activity.collaborators,
          status: "Ongoing",
          category: state.category ?? activity.category,
          startTime: state.startTime ?? activity.startTime,
          endTime: state.endTime ?? activity.endTime);

      activityRepository.updateActivity(activity);

    } catch (error) {}
  }
}
