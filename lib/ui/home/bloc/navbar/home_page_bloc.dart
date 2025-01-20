import 'package:equatable/equatable.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ActivityRepository activityRepository;

  HomePageBloc({required this.activityRepository})
      : super(const HomePageLoadingState(index: 0, previousIndex: 0)) {
    on<ChangeIndexEvent>(_onIndexChange);
    _initialize();
  }

  void _initialize() async {
    add(ChangeIndexEvent(index: state.index));
  }

  void _onIndexChange(
      ChangeIndexEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState(index: event.index, previousIndex: state.index));
    try {
      Stream<List<Activity>> stream = _getActivityStreamByIndex(event.index);

      await emit.forEach<List<Activity>>(stream, onData: (activities) {
        final now = DateTime.now();
        final categorizedActivities =
            activities.fold<Map<String, List<Activity>>>(
          {
            'upcoming': [],
            'ongoing': [],
            'completed': [],
          },
          (map, activity) {
            final startDate = activity.startTime;
            final endDate = activity.endTime;

            if (endDate!.isBefore(now)) {
              map['completed']!.add(activity);
            } else if (startDate!.isAfter(now)) {
              map['upcoming']!.add(activity);
            } else {
              map['ongoing']!.add(activity);
            }

            return map;
          },
        );

        print(  "$categorizedActivities   $activities");

        categorizedActivities['upcoming']!
            .sort((a, b) => a.startTime!.compareTo(b.startTime!));
        categorizedActivities['ongoing']!
            .sort((a, b) => a.endTime!.compareTo(b.endTime!));
        categorizedActivities['completed']!
            .sort((a, b) => b.endTime!.compareTo(a.endTime!));

        return HomePageSuccessState(
          index: event.index,
          previousIndex: state.index,
          upcoming: categorizedActivities['upcoming']!,
          ongoing: categorizedActivities['ongoing']!,
          completed: categorizedActivities['completed']!,
          activites: activities
        );
      });
    } catch (error) {
      emit(HomePageErrorState(index: event.index, previousIndex: state.index));
    }
  }

  Stream<List<Activity>> _getActivityStreamByIndex(int index) {
    switch (index) {
      case 0:
        return activityRepository.getTodaysActivitiesStream();
      case 1:
        return activityRepository.getUpcomingActivites();
      case 2:
        return activityRepository.getPastActivities();
      default:
        throw Exception('Invalid index');
    }
  }
}
