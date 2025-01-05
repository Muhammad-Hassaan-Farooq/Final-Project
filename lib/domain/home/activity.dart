class Activity {
  final String id;
  final String ownerId;
  final String title;
  final DateTime? startTime;
  final DateTime? endTime;
  final String category;
  final List<String> collaborators;
  final String status;
  final Duration? duration;

  Activity({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.collaborators,
    required this.status,
    this.startTime,
    this.endTime,
    this.duration,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'ownerId': ownerId,
        'collaborators': collaborators,
        'status': status,
        'startTime': startTime?.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'duration': duration?.inSeconds,
        'category': category,
      };

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'],
        title: json['title'],
        ownerId: json['ownerId'],
        collaborators: List<String>.from(json['collaborators']),
        status: json['status'],
        startTime: json['startTime'] != null
            ? DateTime.parse(json['startTime'])
            : null,
        endTime:
            json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
        duration: json['duration'] != null
            ? Duration(seconds: json['duration'])
            : null,
        category: json['category'],
      );

  Activity copyWith({
    String? id,
    String? title,
    String? ownerId,
    List<String>? collaborators,
    String? status,
    DateTime? startTime,
    DateTime? endTime,
    Duration? duration,
    String? category,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      ownerId: ownerId ?? this.ownerId,
      collaborators: collaborators ?? this.collaborators,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      category: category ?? this.category,
    );
  }
}
