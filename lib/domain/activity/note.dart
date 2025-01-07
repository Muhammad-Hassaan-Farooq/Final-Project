import 'package:cloud_firestore/cloud_firestore.dart';

enum NOTE_TYPE { IMAGE, TEXT, AUDIO }

class Note {
  final String id;
  final String activityId;
  final String userId;
  final String content;
  final DateTime timestamp;
  final NOTE_TYPE note_type;

  Note({
    required this.id,
    required this.activityId,
    required this.userId,
    required this.content,
    required this.timestamp,
    required this.note_type,
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'activityId': activityId,
        'userId': userId,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
        'note_type': note_type
            .toString()
            .split('.')
            .last, // Convert enum to string
      };

  factory Note.fromJson(Map<String, dynamic> json) =>
      Note(
        id: json['id'],
        activityId: json['activityId'],
        userId: json['userId'],
        content: json['content'],
        timestamp: DateTime.parse(json['timestamp']),
        note_type: NOTE_TYPE.values.firstWhere(
              (e) =>
          e
              .toString()
              .split('.')
              .last == json['note_type'],
        ),
      );

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;


    return Note(
      id: doc.id,
      activityId: data['activityId'] ?? '',
      userId: data['userId'] ?? '',
      content: data['content'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      note_type: NOTE_TYPE.values.firstWhere(
            (e) => e.toString().split('.').last == data['note_type'],
        orElse: () => NOTE_TYPE.TEXT,
      ),
    );
  }
}