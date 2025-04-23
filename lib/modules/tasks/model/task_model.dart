import 'package:frontend/modules/tasks/model/single_task.dart';

class TaskModel {
  final String id;
  final String userId;
  final List<SingleTask> dailyTask;
  final List<SingleTask> weeklyTask;

  TaskModel({
    required this.id,
    required this.userId,
    required this.dailyTask,
    required this.weeklyTask,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      userId: json['userId'],
      dailyTask:
          (json['dailyTask'] as List)
              .map((e) => SingleTask.fromJson(e))
              .toList(),
      weeklyTask:
          (json['weeklyTask'] as List)
              .map((e) => SingleTask.fromJson(e))
              .toList(),
    );
  }
}
