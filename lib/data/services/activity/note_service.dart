import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/domain/activity/note.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get userID => FirebaseAuth.instance.currentUser!.uid;

  Stream<List<Note>> getNotesStreamForActivity(String activityId) {
    return _firestore
          .collection('notes')
          .where('activityId', isEqualTo: activityId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => Note.fromFirestore(doc))
              .toList());
  }

  Future<List<Note>> getNotesForActivity(String activityId) async {
    final querySnapshot = await _firestore
        .collection('notes')
        .where('activityId', isEqualTo: activityId)
        .get();

    return querySnapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  Future<void> addNote(Note note) async {
    await _firestore.collection('notes').add({
      'activityId': note.activityId,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'content': note.content,
      'timestamp': note.timestamp
    });
  }

  Future<void> updateNote(String noteId, String content) async {
    await _firestore.collection('notes').doc(noteId).update({
      'content':content
    });
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }

  Future<Note?> getNoteById(String noteId) async {
    final doc = await _firestore.collection('notes').doc(noteId).get();
    if (doc.exists) {
      return Note.fromFirestore(doc);
    }
    return null;
  }

  Future<String> getEmail(String userId) async{
    try {
      var docSnapshot = await _firestore.collection('users').doc(userId).get();

      if (docSnapshot.exists) {
        String email = docSnapshot.data()?['email'] ?? '';
        return email;
      } else {
        return 'User not found';
      }
    } catch (e) {
      return 'Error fetching email: $e';
    }
  }
}
