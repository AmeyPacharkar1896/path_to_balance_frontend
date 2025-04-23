// models/task_model.dart
class SingleTask {
  final String id;
  final String title;
  final String description;
  final bool status;

  SingleTask({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory SingleTask.fromJson(Map<String, dynamic> json) {
    return SingleTask(
      id: json['_id'],
      title: json['Title'],
      description: json['Description'],
      status: json['status'],
    );
  }
}
