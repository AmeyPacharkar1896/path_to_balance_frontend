import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/provider/task_provider.dart';
import 'package:provider/provider.dart';

class WeeklyTasksPage extends StatefulWidget {
  const WeeklyTasksPage({super.key});

  @override
  State<WeeklyTasksPage> createState() => _WeeklyTasksPageState();
}

class _WeeklyTasksPageState extends State<WeeklyTasksPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<TasksProvider>(context, listen: false);
      if (!provider.isWeeklyLoaded) {
        provider.loadTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Weekly Tasks")),
      body: tasksProvider.weeklyTasks.isEmpty
          ? const Center(child: Text("No weekly tasks found."))
          : ListView.builder(
              itemCount: tasksProvider.weeklyTasks.length,
              itemBuilder: (context, index) {
                final task = tasksProvider.weeklyTasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Switch(
                      value: task.status,
                      onChanged: (val) {
                        tasksProvider.toggleTaskCompletion(task.id, false);
                      },
                      activeColor: Colors.green,
                    ),
                    leading: Icon(
                      task.status ? Icons.check_circle : Icons.circle_outlined,
                      color: task.status ? Colors.green : Colors.grey,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
