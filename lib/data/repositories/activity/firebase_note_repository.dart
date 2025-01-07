import 'package:final_project/data/repositories/activity/note_repository.dart';
import 'package:final_project/data/services/activity/note_service.dart';
import 'package:final_project/domain/activity/note.dart';

class FirebaseNoteRepository extends NoteRepository {
  final NoteService _noteService = NoteService();

  @override
  Future<void> addNote(Note note) async {
    await _noteService.addNote(note);
    notifyListeners();
  }

  @override
  Future<void> deleteNote(String noteId) async {
    await _noteService.deleteNote(noteId);
    notifyListeners();
  }

  @override
  Future<Note?> getNoteById(String noteId) async {
    return await _noteService.getNoteById(noteId);
  }

  @override
  Future<List<Note>> getNotesForActivity(String activityId) async {
    return await _noteService.getNotesForActivity(activityId);
  }

  @override
  Stream<List<Note>> getNotesStreamForActivity(String activityId) {
    return _noteService.getNotesStreamForActivity(activityId);
  }

  @override
  Future<void> updateNote(String noteId, String content) async {
    await _noteService.updateNote(noteId,content);
    notifyListeners();
  }

  @override
  String get userId => _noteService.userID;

  @override
  Future<String> getEmail(String userId) {
    return _noteService.getEmail(userId);
  }
}
