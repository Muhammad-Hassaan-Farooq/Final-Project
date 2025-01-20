import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/activity/note_repository.dart';
import '../../../data/repositories/home/activity_repository.dart';
import '../../../domain/activity/note.dart';
import '../../../domain/home/activity.dart';

part 'activity_state.dart';
part 'activity_event.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityRepository _activityRepository;
  final NoteRepository _noteRepository;
  final String _activityId;
  StreamSubscription<List<Note>>? _noteStreamSubscription;
  String get userID => _noteRepository.userId;

  ActivityBloc({
    required ActivityRepository activityRepository,
    required NoteRepository noteRepository,
    required String activityId,
    required Activity activity,
  })  : _activityRepository = activityRepository,
        _noteRepository = noteRepository,
        _activityId = activityId,
        super(ActivityLoadingState(activity)) {
    on<InitializeActivity>(_onInitialize);
    on<AddNoteEvent>(_onAddNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<GetEmailEvent>(_onGetEmail);

    add(InitializeActivity());
  }

  Future<void> _onInitialize(
      InitializeActivity event,
      Emitter<ActivityState> emit,
      ) async {
    try {
      final activity = state.activity;
      final isActive = _checkIfActive(activity);

      await _noteStreamSubscription?.cancel();
      _noteStreamSubscription = _noteRepository
          .getNotesStreamForActivity(_activityId)
          .listen((notes) {
        final sortedNotes = List<Note>.from(notes)
          ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
        emit(ActivityLoadedState(activity, sortedNotes, isActive));
      });
    } catch (error) {
      emit(ActivityErrorState(state.activity, error.toString()));
    }
  }

  Future<void> _onAddNote(
      AddNoteEvent event,
      Emitter<ActivityState> emit,
      ) async {
    try {
      await _noteRepository.addNote(Note(
        id: "1",
        activityId: _activityId,
        userId: "",
        content: event.content,
        timestamp: DateTime.now(),
        note_type: NOTE_TYPE.TEXT,
      ));
    } catch (error) {
      emit(ActivityErrorState(state.activity, error.toString()));
    }
  }

  Future<void> _onDeleteNote(
      DeleteNoteEvent event,
      Emitter<ActivityState> emit,
      ) async {
    try {
      await _noteRepository.deleteNote(event.noteId);
    } catch (error) {
      emit(ActivityErrorState(state.activity, error.toString()));
    }
  }

  Future<void> _onUpdateNote(
      UpdateNoteEvent event,
      Emitter<ActivityState> emit,
      ) async {
    try {
      await _noteRepository.updateNote(event.noteId, event.content);
    } catch (error) {
      emit(ActivityErrorState(state.activity, error.toString()));
    }
  }

  Future<void> _onGetEmail(
      GetEmailEvent event,
      Emitter<ActivityState> emit,
      ) async {
    try {
      final email = await _noteRepository.getEmail(event.userId);
    } catch (error) {
      emit(ActivityErrorState(state.activity, error.toString()));
    }
  }

  bool _checkIfActive(Activity activity) {
    final now = DateTime.now();
    return now.isAfter(DateTime(
      activity.startTime!.year,
      activity.startTime!.month,
      activity.startTime!.day,
      activity.startTime!.hour,
      activity.startTime!.minute,
    )) &&
        now.isBefore(DateTime(
          activity.endTime!.year,
          activity.endTime!.month,
          activity.endTime!.day,
          activity.endTime!.hour,
          activity.endTime!.minute,
        ));
  }

  @override
  Future<void> close() {
    _noteStreamSubscription?.cancel();
    return super.close();
  }
}