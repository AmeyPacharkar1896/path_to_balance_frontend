import 'package:flutter/material.dart';
import 'package:frontend/features/tasks/presentation/provider/task_provider.dart';
import 'package:provider/provider.dart';

class WeeklyTasksPage extends StatelessWidget {
  const WeeklyTasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Weekly Tasks")),
      body: ListView.builder(
        itemCount: tasksProvider.weeklyTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasksProvider.weeklyTasks[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: add a new weekly task
          tasksProvider.addWeeklyTask("New Weekly Task");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
