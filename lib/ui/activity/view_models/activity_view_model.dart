import 'package:final_project/data/repositories/activity/note_repository.dart';
import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/domain/activity/note.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/cupertino.dart';

enum UIState { LOADING, SUCCESS, ERROR }

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _activityRepository;
  final NoteRepository _noteRepository;
  final String _activityId;
  UIState _state = UIState.LOADING;
  UIState get currentState => _state;
  Activity _activity;
  Activity get activity => _activity;
  late List<Note> _notes;
  List<Note> get notes => _notes;
  Stream<List<Note>>? _noteStream;
  bool isActive = false;
  String get userID => _noteRepository.userId;

  ActivityViewModel({
    required ActivityRepository activityRepository,
    required NoteRepository noteRepository,
    required String activityId,
    required Activity activity,
  })  : _activityRepository = activityRepository,
        _noteRepository = noteRepository,
        _activityId = activityId,
        _activity = activity {
    _initialise();
  }

  Future<void> _initialise() async {
    _noteStream = _noteRepository.getNotesStreamForActivity(_activityId);
    isActive = DateTime.now().isAfter(DateTime(
          _activity.startTime!.year,
          _activity.startTime!.month,
          _activity.startTime!.day,
          _activity.startTime!.hour,
          _activity.startTime!.minute,
        )) &&
        DateTime.now().isBefore(DateTime(
          _activity.endTime!.year,
          _activity.endTime!.month,
          _activity.endTime!.day,
          _activity.endTime!.hour,
          _activity.endTime!.minute,
        ));
    notifyListeners();
    _noteStream!.listen((notes) {
      if (notes.isEmpty) {
        _state = UIState.SUCCESS;
        _notes = [];
      } else {
        _notes = notes;
        _state = UIState.SUCCESS;
        _notes.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }
      notifyListeners();
    }, onError: (error) {
      _state = UIState.ERROR;
      notifyListeners();
    });
  }

  Future<void> addNote(String content) async {
    _noteRepository.addNote(Note(
        id: "1",
        activityId: _activityId,
        userId: "",
        content: content,
        timestamp: DateTime.now(),
        note_type: NOTE_TYPE.TEXT));
  }

  Future<void> deleteNote(String noteId) async {
    _noteRepository.deleteNote(noteId);
  }

  Future<void> updateNote(String noteId, String content) async {
    _noteRepository.updateNote(noteId, content);
  }

  Future<String> getEmail(String userId) async{
    return await _noteRepository.getEmail(userId);
  }
}
