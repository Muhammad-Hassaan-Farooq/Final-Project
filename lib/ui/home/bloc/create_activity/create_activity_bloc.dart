import 'package:equatable/equatable.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_activity_event.dart';
part 'create_activity_state.dart';

class CreateActivityBloc
    extends Bloc<CreateActivityEvent, CreateActivityState> {
  final ActivityRepository activityRepository;
  late final List<Map<String, dynamic>> collaborators;

  CreateActivityBloc({required this.activityRepository})
      : super(CreateActivityState()) {
    on<ChangeFormInputEvent>(_onInputChange);
    on<SubmitEvent>(_onSubmit);
    _init();

  }

  void _init() async{
  collaborators = await activityRepository.fetchCollaborators();
}

  void _onInputChange(
      ChangeFormInputEvent event, Emitter<CreateActivityState> emit) {
    emit(CreateActivityState(
      title: event.title ?? state.title,
      category: event.category ?? state.category,
      startTime: event.startTime ?? state.startTime,
      endTime: event.endTime ?? state.endTime,
    ));
  }

  void _onSubmit(SubmitEvent event, Emitter<CreateActivityState> emit) {
    try {
      activityRepository.addActivity(Activity(
          id: "1",
          title: state.title!,
          ownerId: "",
          collaborators: [],
          status: "Ongoing",
          category: state.category!,
          startTime: state.startTime,
          endTime: state.endTime));
    } catch (error) {}
  }
}
