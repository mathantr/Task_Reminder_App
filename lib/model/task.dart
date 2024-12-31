class Task {
  final String title;
  final String description;
  final DateTime reminderTime;

  Task({
    required this.title,
    required this.description,
    required this.reminderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'reminderTime': reminderTime.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      reminderTime: DateTime.parse(map['reminderTime']),
    );
  }
}
