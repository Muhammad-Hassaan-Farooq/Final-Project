part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  final int index;
  final int previousIndex;

  const HomePageState({required this.index, required this.previousIndex});

  @override
  List<Object?> get props => [index];
}

class HomePageLoadingState extends HomePageState {
  const HomePageLoadingState(
      {required super.index, required super.previousIndex});
}

class HomePageSuccessState extends HomePageState {
  final List<Activity> ongoing;
  final List<Activity> upcoming;
  final List<Activity> completed;
  final List<Activity> activites;

  const HomePageSuccessState(
      {required super.index,
      required super.previousIndex,
      required this.ongoing,
      required this.upcoming,
      required this.completed,
      required this.activites});
}

class HomePageErrorState extends HomePageState {
  const HomePageErrorState(
      {required super.index, required super.previousIndex});
}
