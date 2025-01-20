import 'package:final_project/ui/activity/view_models/activity_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:final_project/data/repositories/activity/mock_note_repository.dart';
import 'package:final_project/domain/home/activity.dart';
void main() {
  late ActivityViewModel viewModel;
  late MockActivityRepository mockActivityRepository;
  late MockNoteRepository mockNoteRepository;
  late Activity testActivity;
  setUp(() {
    mockActivityRepository = MockActivityRepository();
    mockNoteRepository = MockNoteRepository();
    final now = DateTime.now();
    testActivity = Activity(
      id: 'test_activity',
      title: 'Test Activity',
      ownerId: 'user_001',
      collaborators: [],
      status: 'Ongoing',
      startTime: now.subtract(Duration(hours: 1)),
      endTime: now.add(Duration(hours: 1)),
      duration: Duration(hours: 2),
      category: 'Test',
    );
    viewModel = ActivityViewModel(
      activityRepository: mockActivityRepository,
      noteRepository: mockNoteRepository,
      activityId: testActivity.id,
      activity: testActivity,
    );
  });
  group('ActivityViewModel Initialization Tests', () {
    test('should have correct activity', () {
      expect(viewModel.activity, equals(testActivity));
    });
    test('should have empty initial notes list', () {
      expect(viewModel.notes, isEmpty);
    });
    test('should have correct userId', () {
      expect(viewModel.userID, equals('user_001'));
    });
    test('should determine if activity is active correctly', () {
      expect(viewModel.isActive, isTrue);
    });
  });
  group('ActivityViewModel Note Management Tests', () {
    test('should add note successfully', () async {
      await viewModel.addTextNote('Test note content');
      final notes = await mockNoteRepository.getNotesForActivity(testActivity.id);
      expect(notes.length, equals(1));
      expect(notes.first.content, equals('Test note content'));
    });
    test('should delete note successfully', () async {
      await viewModel.addTextNote('Test note content');
      final notes = await mockNoteRepository.getNotesForActivity(testActivity.id);
      final noteId = notes.first.id;
      await viewModel.deleteNote(noteId);
      final updatedNotes = await mockNoteRepository.getNotesForActivity(testActivity.id);
      expect(updatedNotes, isEmpty);
    });
    test('should update note successfully', () async {
      await viewModel.addTextNote('Initial content');
      final notes = await mockNoteRepository.getNotesForActivity(testActivity.id);
      final noteId = notes.first.id;
      await viewModel.updateNote(noteId, 'Updated content');
      final updatedNote = await mockNoteRepository.getNoteById(noteId);
      expect(updatedNote?.content, equals('Updated content'));
    });
  });
  group('ActivityViewModel Email Tests', () {
    test('should get email successfully', () async {
      final email = await viewModel.getEmail('user_001');
      expect(email, equals('test@gmail.com'));
    });
  });
  group('ActivityViewModel Activity Status Tests', () {
    test('should mark future activity as inactive', () {
      final futureActivity = Activity(
        id: 'future_activity',
        title: 'Future Activity',
        ownerId: 'user_001',
        collaborators: [],
        status: 'Scheduled',
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 2)),
        duration: Duration(hours: 2),
        category: 'Test',
      );
      final futureViewModel = ActivityViewModel(
        activityRepository: mockActivityRepository,
        noteRepository: mockNoteRepository,
        activityId: futureActivity.id,
        activity: futureActivity,
      );
      expect(futureViewModel.isActive, isFalse);
    });
    test('should mark past activity as inactive', () {
      final pastActivity = Activity(
        id: 'past_activity',
        title: 'Past Activity',
        ownerId: 'user_001',
        collaborators: [],
        status: 'Completed',
        startTime: DateTime.now().subtract(Duration(days: 2)),
        endTime: DateTime.now().subtract(Duration(days: 2, hours: 2)),
        duration: Duration(hours: 2),
        category: 'Test',
      );
      final pastViewModel = ActivityViewModel(
        activityRepository: mockActivityRepository,
        noteRepository: mockNoteRepository,
        activityId: pastActivity.id,
        activity: pastActivity,
      );
      expect(pastViewModel.isActive, isFalse);
    });
  });
  group('ActivityViewModel Stream Tests', () {
    test('should handle empty notes stream', () async {
      await Future.delayed(Duration(milliseconds: 100));
      expect(viewModel.currentState, equals(UIState.SUCCESS));
      expect(viewModel.notes, isEmpty);
    });
  });
}