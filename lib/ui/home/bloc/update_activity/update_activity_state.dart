part of 'update_activity_bloc.dart';

class UpdateActivityState extends Equatable {
  final String? title;
  final String? category;
  final DateTime? startTime;
  final DateTime? endTime;

  const UpdateActivityState(
      {required this.title,
      required this.category,
      required this.startTime,
      required this.endTime});

  @override
  List<Object?> get props => [title, category, startTime, endTime];
}
