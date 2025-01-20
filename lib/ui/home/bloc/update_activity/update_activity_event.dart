part of 'update_activity_bloc.dart';

abstract class UpdateActivityEvent{}

class ChangeFormInputEvent extends UpdateActivityEvent{
  final String? title;
  final String? category;
  final DateTime? startTime;
  final DateTime? endTime;

  ChangeFormInputEvent({this.title,this.category,this.startTime,this.endTime});

}

class SubmitEvent extends UpdateActivityEvent{

}