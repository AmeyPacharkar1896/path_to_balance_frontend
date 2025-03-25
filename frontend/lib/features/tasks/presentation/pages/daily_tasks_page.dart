import 'package:flutter/material.dart';
import 'package:frontend/features/tasks/presentation/provider/task_provider.dart';
import 'package:provider/provider.dart';

class DailyTasksPage extends StatelessWidget {
  const DailyTasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Tasks")),
      body: ListView.builder(
        itemCount: tasksProvider.dailyTasks.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(tasksProvider.dailyTasks[index]));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: add a new daily task (in a real app, use a dialog to enter text)
          tasksProvider.addDailyTask("New Daily Task");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
