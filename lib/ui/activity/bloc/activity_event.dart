part of 'activity_bloc.dart';


abstract class ActivityEvent {}

class InitializeActivity extends ActivityEvent {}

class AddNoteEvent extends ActivityEvent {
  final String content;
  AddNoteEvent(this.content);
}

class DeleteNoteEvent extends ActivityEvent {
  final String noteId;
  DeleteNoteEvent(this.noteId);
}

class UpdateNoteEvent extends ActivityEvent {
  final String noteId;
  final String content;
  UpdateNoteEvent(this.noteId, this.content);
}

class GetEmailEvent extends ActivityEvent {
  final String userId;
  GetEmailEvent(this.userId);
}