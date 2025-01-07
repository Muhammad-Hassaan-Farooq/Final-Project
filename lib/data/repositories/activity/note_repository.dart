import 'package:final_project/domain/activity/note.dart';
import 'package:flutter/material.dart';

abstract class NoteRepository extends ChangeNotifier {
  Stream<List<Note>> getNotesStreamForActivity(String activityId);
  String get userId;

  Future<List<Note>> getNotesForActivity(String activityId);

  Future<void> addNote(Note note);


  Future<void> updateNote(String noteId, String content);

  Future<void> deleteNote(String noteId);

  Future<Note?> getNoteById(String noteId);
  Future<String> getEmail(String userId);
}
