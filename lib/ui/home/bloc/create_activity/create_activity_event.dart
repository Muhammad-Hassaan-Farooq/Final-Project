part of 'create_activity_bloc.dart';

abstract class CreateActivityEvent{}

class ChangeFormInputEvent extends CreateActivityEvent{
  final String? title;
  final String? category;
  final DateTime? startTime;
  final DateTime? endTime;

  ChangeFormInputEvent({this.title,this.category,this.startTime,this.endTime});

}

class SubmitEvent extends CreateActivityEvent{

}