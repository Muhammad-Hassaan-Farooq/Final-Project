part of 'create_activity_bloc.dart';

class CreateActivityState extends Equatable {
  final String? title;
  final String? category;
  final DateTime? startTime;
  final DateTime? endTime;

  CreateActivityState(
      {this.title, this.category, this.startTime, this.endTime});

  List<Object?> get props => [title, category, startTime, endTime];
}
