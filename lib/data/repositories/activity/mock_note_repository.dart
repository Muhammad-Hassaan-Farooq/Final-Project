import 'package:final_project/data/repositories/activity/note_repository.dart';
import 'package:final_project/domain/activity/note.dart';

class MockNoteRepository extends NoteRepository {
  final List<Note> _notes = [];

  @override
  Future<void> addNote(Note note) async {
    _notes.add(note);
    notifyListeners();
  }

  @override
  Future<void> deleteNote(String noteId) async {
    _notes.removeWhere((note) => note.id == noteId);
    notifyListeners();
  }

  @override
  Future<Note?> getNoteById(String noteId) async {
    return _notes.firstWhere((note) => note.id == noteId,
        orElse: () => null as Note);
  }

  @override
  Future<List<Note>> getNotesForActivity(String activityId) async {
    return _notes.where((note) => note.activityId == activityId).toList();
  }

  @override
  Stream<List<Note>> getNotesStreamForActivity(String activityId) async* {
    yield _notes.where((note) => note.activityId == activityId).toList();
  }

  @override
  Future<void> updateNote(String noteId, String content) async {
    final index = _notes.indexWhere((n) => n.id == noteId);
    if (index != -1) {
      _notes[index] = Note(
          id: noteId,
          activityId: _notes[index].activityId,
          userId: userId,
          content: content,
          timestamp: _notes[index].timestamp,
          note_type: _notes[index].note_type);
      notifyListeners();
    }
  }

  @override
  String get userId => "user_001";

  @override
  Future<String> getEmail(String userId) async{
    return "test@gmail.com";
  }
}
